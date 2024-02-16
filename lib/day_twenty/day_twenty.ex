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
						destination_module_key = String.to_existing_atom(destination_module)

            case Map.get(acc, destination_module_key) do
              {:conjunction, _, _} ->
                Map.update!(acc, destination_module_key, fn {type, destinations, state} ->
                  {type, destinations, [{module_name, :off} | state]}
                end)

              {:flip_flop, _, _} ->
                acc

              nil ->
                Map.put(acc, String.to_atom(destination_module), {:untyped})
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
        {String.to_atom(name), {:flip_flop, String.split(destination_modules, ", "), :off}}

      <<"&", name::binary>> ->
        {String.to_atom(name), {:conjunction, String.split(destination_modules, ", "), []}}
    end
  end
end
