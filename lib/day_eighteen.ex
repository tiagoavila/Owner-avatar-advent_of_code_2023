defmodule DayEighteen do
  def part_one(input) do
    dig_map = Map.new() |> Map.put({0, 0}, "#")

    input
    |> Enum.reduce({dig_map, {0, 0}}, fn line, {dig_map, {last_row, last_col}} ->
      [dir, meters, _] = String.split(line, " ", trim: true)
      parsed_meters = String.to_integer(meters)

      case dir do
        "R" ->
          1..parsed_meters
          |> Enum.into(dig_map, fn i -> {{last_row, last_col + i}, "#"} end)
          |> then(fn new_map -> {new_map, {last_row, last_col + parsed_meters}} end)

        "L" ->
          1..parsed_meters
          |> Enum.into(dig_map, fn i -> {{last_row, last_col - i}, "#"} end)
          |> then(fn new_map -> {new_map, {last_row, last_col - parsed_meters}} end)

        "D" ->
          1..parsed_meters
          |> Enum.into(dig_map, fn i -> {{last_row + i, last_col}, "#"} end)
          |> then(fn new_map -> {new_map, {last_row + parsed_meters, last_col}} end)

        "U" ->
          1..parsed_meters
          |> Enum.into(dig_map, fn i -> {{last_row - i, last_col}, "#"} end)
          |> then(fn new_map -> {new_map, {last_row - parsed_meters, last_col}} end)
      end
    end)
		|> tap(fn {dig_map, _} ->
			Enum.min(Map.keys(dig_map)) |> IO.inspect(label: "min key")
			Enum.max(Map.keys(dig_map)) |> IO.inspect(label: "max key")
		end)

    62
  end

  def part_two(input) do
  end
end
