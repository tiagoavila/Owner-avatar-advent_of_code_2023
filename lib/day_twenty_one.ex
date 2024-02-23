defmodule DayTwentyOne do
  @directions [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  ]

  def part_one(input, max_steps \\ 64) do
    {map, s_position} =
      input
      |> parse_list_of_lists_to_map()

    {queue, seen} = process_neighbors(map, Qex.new(), MapSet.new(), s_position, 1, max_steps)

    process_steps(map, queue, seen, max_steps)
    |> Map.values()
    |> Enum.count(&(&1 == "O"))
  end

  def part_two(input) do
  end

  def process_steps(map, queue, seen, max_steps) do
    {value, queue} = Qex.pop(queue)

    case value do
      {:value, {current_pos, step}} when step == max_steps - 1 ->
        map = Enum.reduce(@directions, map, fn {row, col}, map ->
          neighbor = {elem(current_pos, 0) + row, elem(current_pos, 1) + col}

          if Map.get(map, neighbor) != "#" do
            Map.replace(map, neighbor, "O")
          else
            map
          end
        end)
        process_steps(map, queue, seen, max_steps)

      {:value, {current_pos, step}} ->
        {queue, seen} = process_neighbors(map, queue, seen, current_pos, step + 1, max_steps)
        process_steps(map, queue, seen, max_steps)

      _ ->
        map
    end
  end

  def process_neighbors(map, queue, seen, current_pos, step, max_steps) do
    Enum.reduce(@directions, {queue, seen}, fn {row, col}, {queue, seen} ->
      neighbor = {elem(current_pos, 0) + row, elem(current_pos, 1) + col}

      if Map.get(map, neighbor) != "#" && !MapSet.member?(seen, neighbor) do
        {Qex.push(queue, {neighbor, step}), MapSet.put(seen, neighbor)}
      else
        {queue, seen}
      end
    end)
  end

  def parse_list_of_lists_to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce({%{}, {}}, fn {line, row_idx}, {map, s_position} ->
      s_position =
        if String.contains?(line, "S") do
          {row_idx, String.graphemes(line) |> Enum.find_index(&(&1 == "S"))}
        else
          s_position
        end

      map =
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.into(map, fn {char, col_idx} ->
          {{row_idx, col_idx}, char}
        end)

      {map, s_position}
    end)
  end
end
