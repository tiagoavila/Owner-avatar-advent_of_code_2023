defmodule DayTwenty do
  alias DayTwenty.FlipFlopServer
  alias DayTwenty.ConjunctionServer

  def part_one(input) do
    modules_map = parse_input_to_map(input) |> tap(&initialize_servers/1)

    1..1000
    |> Enum.reduce(%{low: 0, high: 0}, fn _i, pulse_count ->
      queue =
        modules_map[:broadcaster]
        |> Enum.map(&{:broadcaster, &1, :low})
        |> Qex.new()

      pulse_count = update_pulse_count(pulse_count, :low)

      process_p1(modules_map, queue, pulse_count)
    end)
    |> Map.values()
    |> Enum.product()
  end

  def part_two(input) do
  end

  def process_p1(modules_map, queue, pulse_count) do
    {value, queue} = Qex.pop(queue)

    case value do
      {:value, {_, current_module, pulse} = queue_item} ->
        pulse_count = update_pulse_count(pulse_count, pulse)

        queue =
          case send_pulse(queue_item, modules_map) do
            {next_modules, pulse_to_send} ->
              next_modules
              |> Enum.reduce(queue, fn next_module_name, acc ->
                Qex.push(acc, {current_module, next_module_name, pulse_to_send})
              end)

            {} ->
              queue
          end

        process_p1(modules_map, queue, pulse_count)

      _ ->
        pulse_count
    end
  end

  defp send_pulse({sender_module, destination_module, pulse}, modules_map) do
    case Map.get(modules_map, destination_module) do
      {:conjunction, _, _} ->
        ConjunctionServer.send_pulse(destination_module, pulse, sender_module)

      {:flip_flop, _, _} ->
        FlipFlopServer.send_pulse(destination_module, pulse)

      _ ->
        {}
    end
  end

  def parse_input_to_map(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.into(%{}, &parse_input_line_to_module/1)
    |> then(fn map ->
      map
      |> Enum.reduce(map, fn {module_name, value}, acc ->
        if module_name == :broadcaster do
          acc
        else
          {_module_type, destination_modules, _state} = value

          Enum.reduce(destination_modules, acc, fn destination_module, acc ->
            case Map.get(acc, destination_module) do
              {:conjunction, _, _} ->
                Map.update!(acc, destination_module, fn {type, destinations, module_state} ->
                  updated_module_state = Map.put(module_state, module_name, :low)
                  {type, destinations, updated_module_state}
                end)

              nil ->
                Map.put(acc, destination_module, {:untyped})

              _ ->
                acc
            end
          end)
        end
      end)
    end)
  end

  def parse_input_line_to_module(line) do
    [module_name, destination_modules] = String.split(line, " -> ")

    destination_modules =
      destination_modules
      |> String.split(", ")
      |> Enum.map(&String.to_atom/1)

    case module_name do
      "broadcaster" ->
        {:broadcaster, destination_modules}

      <<"%", name::binary>> ->
        {String.to_atom(name), {:flip_flop, destination_modules, :off}}

      <<"&", name::binary>> ->
        {String.to_atom(name), {:conjunction, destination_modules, %{}}}
    end
  end

  defp update_pulse_count(pulse_count, pulse) do
    case pulse do
      :low -> Map.update!(pulse_count, :low, &(&1 + 1))
      :high -> Map.update!(pulse_count, :high, &(&1 + 1))
    end
  end

  defp initialize_servers(modules_map) do
    modules_map
    |> Enum.each(fn {module_name, initial_state} ->
      case initial_state do
        {:conjunction, _, _} ->
          GenServer.start_link(ConjunctionServer, initial_state, name: module_name)

        {:flip_flop, _, _} ->
          GenServer.start_link(FlipFlopServer, initial_state, name: module_name)

        _ ->
          nil
      end
    end)
  end
end
