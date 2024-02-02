defmodule DaySeventeen do
  @top {-1, 0}
  @right {0, 1}
  @bottom {1, 0}
  @left {0, -1}

  def part_one(input) do
    input
    |> Helper.parse_list_of_lists_to_map(&String.to_integer(&1))
    |> then(fn map ->
      priority_queue =
        PriorityQueue.new()
        |> PriorityQueue.put(map[{0, 1}], {{0, 1}, @right, 2})
        |> PriorityQueue.put(map[{1, 0}], {{1, 0}, @bottom, 2})

      input_length = length(input)
      target = {(input_length - 1), (input_length - 1)}

      move(map, priority_queue, MapSet.new(), target)
    end)
    |> IO.inspect()

    102
  end

  def part_two(input) do
  end

  defp move(map, priority_queue, seen, target) do
    {current_block, priority_queue} = PriorityQueue.pop(priority_queue)

    case current_block do
      {total_heat_loss, {^target, _, _}} -> total_heat_loss

      {total_heat_loss, {current_pos, direction, remaining_steps}} ->
        if MapSet.member?(seen, current_pos) do
          move(map, priority_queue, seen, target)
        else
          seen = MapSet.put(seen, current_pos)

          priority_queue =
            get_next_blocks(map, current_pos, direction, total_heat_loss, remaining_steps - 1)
            |> push_blocks_to_priority_queue(priority_queue)

          move(map, priority_queue, seen, target)
        end

      {nil, nil} ->
        nil
    end
  end

  defp get_side_blocks_pos({row, col}, direction) do
    cond do
      direction == @bottom or direction == @top ->
        [{{row, col - 1}, @left}, {{row, col + 1}, @right}]

      direction == @left or direction == @right ->
        [{{row - 1, col}, @top}, {{row + 1, col}, @bottom}]

      true ->
        []
    end
  end

  defp get_next_blocks(map, {row, col}, direction, total_heat_loss, remaining_steps) do
    [{side_pos_1, dir_1}, {side_pos_2, dir_2}] = get_side_blocks_pos({row, col}, direction)

    case {Map.get(map, side_pos_1), Map.get(map, side_pos_2)} do
      {side_block_1, nil} ->
        [{side_block_1 + total_heat_loss, {side_pos_1, dir_1, 2}}]

      {nil, side_block_2} ->
        [{side_block_2 + total_heat_loss, {side_pos_2, dir_2, 2}}]

      {side_block_1, side_block_2} ->
        [
          {side_block_1 + total_heat_loss, {side_pos_1, dir_1, 2}},
          {side_block_2 + total_heat_loss, {side_pos_2, dir_2, 2}}
        ]
    end
    |> maybe_get_in_front_block(map, {row, col}, direction, total_heat_loss, remaining_steps)
  end

  defp maybe_get_in_front_block(next_blocks, _, _, _, _, 0), do: next_blocks

  defp maybe_get_in_front_block(
         next_blocks,
         map,
         {row, col},
         {row_dir, col_dir} = dir,
         total_heat_loss,
         remaining_steps
       ) do
    front_block_pos = {row + row_dir, col + col_dir}
    front_block = Map.get(map, front_block_pos)
    [{front_block + total_heat_loss, {front_block_pos, dir, remaining_steps}} | next_blocks]
  end

  defp push_blocks_to_priority_queue(next_blocks, priority_queue) do
    next_blocks |> Enum.reduce(priority_queue, &PriorityQueue.put(&2, &1))
  end
end
