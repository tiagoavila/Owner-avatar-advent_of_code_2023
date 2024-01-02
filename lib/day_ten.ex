defmodule DayTen do
  def part_one(input, {row_dir, col_dir} = start_direction) do
    {sketch_map, {start_row, start_col}} =
      input
      |> parse_sketch_to_map_finding_start_position()

    next_pipe = Map.get(sketch_map, {start_row + row_dir, start_col + col_dir})
    move_and_count_pipes(next_pipe, {start_row + row_dir, start_col + col_dir}, start_direction, sketch_map, 1)
    |> then(&(&1/2))
  end

  defp move_and_count_pipes("S", _, _, _, pipe_count), do: pipe_count

  defp move_and_count_pipes(pipe, pipe_position, direction, sketch_map, pipe_count) when pipe == "|" or pipe == "-" do
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("L", pipe_position, {1, 0}, sketch_map, pipe_count) do
    direction = {0, 1} # Turn right
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("L", pipe_position, {0, -1}, sketch_map, pipe_count) do
    direction = {-1, 0} # Move to top
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("J", pipe_position, {1, 0}, sketch_map, pipe_count) do
    direction = {0, -1} # Turn left
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("J", pipe_position, {0, 1}, sketch_map, pipe_count) do
    direction = {-1, 0} # Move to top
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("F", pipe_position, {0, -1}, sketch_map, pipe_count) do
    direction = {1, 0} # move to bottom
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("F", pipe_position, {-1, 0}, sketch_map, pipe_count) do
    direction = {0, 1} # Turn right
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("7", pipe_position, {0, 1}, sketch_map, pipe_count) do
    direction = {1, 0} # move to bottom
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("7", pipe_position, {-1, 0}, sketch_map, pipe_count) do
    direction = {0, -1} # Turn left
    {next_pipe, next_pipe_position} = get_next_pipe_and_position(pipe_position, direction, sketch_map)
    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp get_next_pipe_and_position({row, col}, {row_dir, col_dir}, sketch_map) do
    next_pipe_position = {row + row_dir, col + col_dir}
    next_pipe = Map.get(sketch_map, next_pipe_position)
    {next_pipe, next_pipe_position}
  end

  defp parse_sketch_to_map_finding_start_position(input) do
    input
    |> String.split("\r\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce({%{}, nil}, fn {line, row_index}, {sketch_map, start_pos} ->
      updated_sketch_map =
        line
        |> String.split("", trim: true)
        |> Enum.with_index()
        |> Enum.reduce(sketch_map, fn {char, col_index}, acc ->
          case char do
            "." -> acc
            _ -> Map.put(acc, {row_index, col_index}, char)
          end
        end)

      start_pos =
        case String.contains?(line, "S") do
          true ->
            col_index =
              line
              |> String.split("", trim: true)
              |> Enum.find_index(&(&1 == "S"))

            {row_index, col_index}

          _ ->
            start_pos
        end

      {updated_sketch_map, start_pos}
    end)
  end

  def part_two(input) do
  end
end
