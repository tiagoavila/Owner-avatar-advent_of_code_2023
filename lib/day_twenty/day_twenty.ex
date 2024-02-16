defmodule DayTwenty do
  def part_one(input) do
    32_000_000
  end

  def part_two(input) do
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

              {:flip_flop, _, _} ->
                acc

              nil ->
                Map.put(acc, destination_module, {:untyped})
            end
          end)
        end
      end)
    end)
  end

  def parse_input_line_to_module(line) do
    [module_name, destination_modules] = String.split(line, " -> ")

    case module_name do
      "broadcaster" ->
        {:broadcaster, String.split(destination_modules, ", ")}

      <<"%", name::binary>> ->
        {String.to_atom(name), {:flip_flop, String.split(destination_modules, ", ") |> Enum.map(&String.to_atom/1), :off}}

      <<"&", name::binary>> ->
        {String.to_atom(name), {:conjunction, String.split(destination_modules, ", ") |> Enum.map(&String.to_atom/1), %{}}}
    end
  end
end
