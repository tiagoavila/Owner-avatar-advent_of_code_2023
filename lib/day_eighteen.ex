defmodule DayEighteen do
  @directions [{-1, 0}, {0, -1}, {1, 0}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}]

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
    |> then(fn {dig_map, _} ->
      {start_row, start_col} =
        Enum.min(Map.keys(dig_map))
        |> then(fn {min_row, min_col} -> {min_row + 1, min_col + 1} end)

      queue = [{start_row, start_col}]

      flood_fill(queue, dig_map)
    end)
    |> Map.keys()
    |> Enum.count()
  end

  def part_two(input) do
  end

  defp flood_fill([], dig_map), do: dig_map

  defp flood_fill(queue, dig_map) do
    [current_pos | queue] = queue

    dig_map = Map.put(dig_map, current_pos, "#")

    Enum.reduce(@directions, queue, fn {row_dir, col_dir}, acc ->
      next_pos = {elem(current_pos, 0) + row_dir, elem(current_pos, 1) + col_dir}

      case Map.has_key?(dig_map, next_pos) do
        false -> [next_pos | acc]
        _ -> acc
      end
    end)
    |> flood_fill(dig_map)
  end
end
