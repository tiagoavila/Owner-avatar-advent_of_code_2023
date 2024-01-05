defmodule DayTen do
  def part_one(input, {row_dir, col_dir} = start_direction) do
    {sketch_map, {start_row, start_col}} =
      input
      |> parse_sketch_to_map_finding_start_position()

    next_pipe = Map.get(sketch_map, {start_row + row_dir, start_col + col_dir})

    move_and_count_pipes(
      next_pipe,
      {start_row + row_dir, start_col + col_dir},
      start_direction,
      sketch_map,
      1
    )
    |> then(&(&1 / 2))
  end

  defp move_and_count_pipes("S", _, _, _, pipe_count), do: pipe_count

  defp move_and_count_pipes(pipe, pipe_position, direction, sketch_map, pipe_count)
       when pipe == "|" or pipe == "-" do
    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("L", pipe_position, {1, 0}, sketch_map, pipe_count) do
    # Turn right
    direction = {0, 1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("L", pipe_position, {0, -1}, sketch_map, pipe_count) do
    # Move to top
    direction = {-1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("J", pipe_position, {1, 0}, sketch_map, pipe_count) do
    # Turn left
    direction = {0, -1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("J", pipe_position, {0, 1}, sketch_map, pipe_count) do
    # Move to top
    direction = {-1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("F", pipe_position, {0, -1}, sketch_map, pipe_count) do
    # move to bottom
    direction = {1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("F", pipe_position, {-1, 0}, sketch_map, pipe_count) do
    # Turn right
    direction = {0, 1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("7", pipe_position, {0, 1}, sketch_map, pipe_count) do
    # move to bottom
    direction = {1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_and_count_pipes(next_pipe, next_pipe_position, direction, sketch_map, pipe_count + 1)
  end

  defp move_and_count_pipes("7", pipe_position, {-1, 0}, sketch_map, pipe_count) do
    # Turn left
    direction = {0, -1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

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

  # "F" and "7" are not edge pipes because let's say a line passes
  # through a "L" and a "7", that means the line only intersect the edge of the poligon once.
  # This video explains it: https://www.youtube.com/watch?v=zhmzPQwgPg0&t=425s
  @edge_pipes ["L", "J", "|"]

  def part_two(input, {row_dir, col_dir} = start_direction, pipe_of_s) do
    {sketch_map, {start_row, start_col}} =
      input
      |> parse_sketch_to_map_finding_start_position()

    pipes_in_loop =
      move_keeping_track_of_pipes(
        Map.get(sketch_map, {start_row + row_dir, start_col + col_dir}),
        {start_row + row_dir, start_col + col_dir},
        start_direction,
        sketch_map,
        MapSet.new() |> MapSet.put({start_row, start_col})
      )

    {row_length, col_length} = get_sketch_dimensions(input)

    sketch_map = Map.update(sketch_map, {start_row, start_col}, pipe_of_s, fn _ -> pipe_of_s end)

    1..(row_length - 2)
    |> Enum.reduce(0, fn row, acc ->
      1..(col_length - 2)
      |> Enum.reduce(acc, fn col, acc ->
        if MapSet.member?(pipes_in_loop, {row, col}) do
          acc
        else
          # traverse row applying the ray casting algorithm
          # https://en.wikipedia.org/wiki/Point_in_polygon#Ray_casting_algorithm
          col + 1..col_length - 1
          |> Enum.reduce(0, fn col_inner_loop, ray_casting_acc ->
            if MapSet.member?(pipes_in_loop, {row, col_inner_loop}) && sketch_map[{row, col_inner_loop}] in @edge_pipes do
              ray_casting_acc + 1
            else
              ray_casting_acc
            end
          end)
          |> then(&(if rem(&1, 2) == 1, do: acc + 1, else: acc))
        end
      end)
    end)
  end

  defp get_sketch_dimensions(input) do
    rows =
      input
      |> String.split("\r\n", trim: true)

    row_length = length(rows)

    col_length = hd(rows) |> String.length()

    {row_length, col_length}
  end

  defp move_keeping_track_of_pipes("S", _, _, _, pipes_in_loop), do: pipes_in_loop

  defp move_keeping_track_of_pipes(pipe, pipe_position, direction, sketch_map, pipes_in_loop)
       when pipe == "|" or pipe == "-" do
    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("L", pipe_position, {1, 0}, sketch_map, pipes_in_loop) do
    # Turn right
    direction = {0, 1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("L", pipe_position, {0, -1}, sketch_map, pipes_in_loop) do
    # Move to top
    direction = {-1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("J", pipe_position, {1, 0}, sketch_map, pipes_in_loop) do
    # Turn left
    direction = {0, -1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("J", pipe_position, {0, 1}, sketch_map, pipes_in_loop) do
    # Move to top
    direction = {-1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("F", pipe_position, {0, -1}, sketch_map, pipes_in_loop) do
    # move to bottom
    direction = {1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("F", pipe_position, {-1, 0}, sketch_map, pipes_in_loop) do
    # Turn right
    direction = {0, 1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("7", pipe_position, {0, 1}, sketch_map, pipes_in_loop) do
    # move to bottom
    direction = {1, 0}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end

  defp move_keeping_track_of_pipes("7", pipe_position, {-1, 0}, sketch_map, pipes_in_loop) do
    # Turn left
    direction = {0, -1}

    {next_pipe, next_pipe_position} =
      get_next_pipe_and_position(pipe_position, direction, sketch_map)

    move_keeping_track_of_pipes(
      next_pipe,
      next_pipe_position,
      direction,
      sketch_map,
      MapSet.put(pipes_in_loop, pipe_position)
    )
  end
end
