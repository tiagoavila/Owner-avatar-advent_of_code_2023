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
        |> PriorityQueue.put(map[{0, 1}], {{0, 1}, @right, 3})
        |> PriorityQueue.put(map[{1, 0}], {{1, 0}, @bottom, 3})

      input_length = length(input)
      target = {input_length - 1, input_length - 1}

      move(map, priority_queue, MapSet.new(), target)
    end)
  end

  def part_two(input) do
    input
    |> Helper.parse_list_of_lists_to_map(&String.to_integer(&1))
    |> then(fn map ->
      priority_queue =
        PriorityQueue.new()
        |> PriorityQueue.put(map[{0, 1}], {{0, 1}, @right, 10})
        |> PriorityQueue.put(map[{1, 0}], {{1, 0}, @bottom, 10})

      input_length = length(input)
      target = {input_length - 1, input_length - 1}

      move_p2(map, priority_queue, MapSet.new(), target)
    end)
  end

  defp move(map, priority_queue, seen, target) do
    {current_block, priority_queue} = PriorityQueue.pop(priority_queue)

    case current_block do
      {total_heat_loss, {^target, _, _}} ->
        total_heat_loss

      {total_heat_loss, {current_pos, direction, remaining_steps}} ->
        if MapSet.member?(seen, {current_pos, direction, remaining_steps}) do
          move(map, priority_queue, seen, target)
        else
          seen = MapSet.put(seen, {current_pos, direction, remaining_steps})

          priority_queue =
            get_side_blocks(map, current_pos, direction, total_heat_loss)
            |> maybe_get_in_front_block(
              map,
              current_pos,
              direction,
              total_heat_loss,
              remaining_steps
            )
            |> push_blocks_to_priority_queue(priority_queue, seen)

          move(map, priority_queue, seen, target)
        end

      {nil, nil} ->
        nil
    end
  end

  defp move_p2(map, priority_queue, seen, target) do
    {current_block, priority_queue} = PriorityQueue.pop(priority_queue)

    case current_block do
      {total_heat_loss, {^target, _, _}} ->
        total_heat_loss

      {total_heat_loss, {current_pos, direction, remaining_steps}} ->
        if MapSet.member?(seen, {current_pos, direction, remaining_steps}) do
          move_p2(map, priority_queue, seen, target)
        else
          seen = MapSet.put(seen, {current_pos, direction, remaining_steps})

          {max_pos, _} = target

          priority_queue =
            get_side_blocks_p2(
              map,
              current_pos,
              direction,
              total_heat_loss,
              remaining_steps,
              max_pos
            )
            |> maybe_get_in_front_block(
              map,
              current_pos,
              direction,
              total_heat_loss,
              remaining_steps
            )
            |> push_blocks_to_priority_queue(priority_queue, seen)

          move_p2(map, priority_queue, seen, target)
        end

      {nil, nil} ->
        nil
    end
  end

  defp get_side_blocks_pos({row, col}, direction) do
    cond do
      direction == @top ->
        [{{row, col + 1}, @right}]

      direction == @bottom ->
        [{{row, col - 1}, @left}, {{row, col + 1}, @right}]

      direction == @left ->
        [{{row + 1, col}, @bottom}]

      direction == @right ->
        [{{row - 1, col}, @top}, {{row + 1, col}, @bottom}]
    end
  end

  defp get_side_blocks(map, {row, col}, direction, total_heat_loss, max_steps_number \\ 3) do
    get_side_blocks_pos({row, col}, direction)
    |> Enum.reduce([], fn {side_pos, dir}, acc ->
      case Map.get(map, side_pos) do
        nil -> acc
        side_block -> [{side_block + total_heat_loss, {side_pos, dir, max_steps_number}} | acc]
      end
    end)
  end

  defp get_side_blocks_p2(map, {row, col}, direction, total_heat_loss, remaining_steps, max_pos) do
    case 10 - remaining_steps >= 3 do
      true ->
        get_side_blocks_pos({row, col}, direction)
        |> Enum.reduce([], fn {side_pos, dir}, acc ->
          case Map.get(map, side_pos) do
            nil -> acc
            side_block -> [{side_block + total_heat_loss, {side_pos, dir, 10}} | acc]
          end
        end)

      _ ->
        []
    end
  end

  defp maybe_get_in_front_block(next_blocks, _, _, _, _, 1), do: next_blocks

  defp maybe_get_in_front_block(
         next_blocks,
         map,
         {row, col},
         {row_dir, col_dir} = dir,
         total_heat_loss,
         remaining_steps
       ) do
    front_block_pos = {row + row_dir, col + col_dir}

    case Map.get(map, front_block_pos) do
      nil ->
        next_blocks

      front_block ->
        [
          {front_block + total_heat_loss, {front_block_pos, dir, remaining_steps - 1}}
          | next_blocks
        ]
    end
  end

  defp push_blocks_to_priority_queue(next_blocks, priority_queue, seen) do
    next_blocks
    |> Enum.reduce(priority_queue, fn {heat_loss, {pos, dir, steps} = block}, acc ->
      case MapSet.member?(seen, {pos, dir, steps}) do
        true -> acc
        false -> PriorityQueue.put(acc, heat_loss, block)
      end
    end)
  end

  def parse_input() do
    input1 = """
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    """

    input2 = """
    2>>>>>>>>1323
    32154535v5623
    32552456v4254
    34465858v5452
    45466578v>>>>
    143859879845v
    445787698776v
    363787797965v
    465496798688v
    456467998645v
    122468686556v
    254654888773v
    432267465553v
    """

    file_path = "example.txt"

    input2_map = input2 |> String.split("\n", trim: true) |> Helper.parse_list_of_lists_to_map()

    input1
    |> String.split("\r\n", trim: true)
    |> Enum.with_index()
    |> Enum.map_join("<br/>", fn {line, row_idx} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map_join(fn {char, col_idx} ->
        case Map.get(input2_map, {row_idx, col_idx}) do
          value when value == char -> char
          _ -> "<span style=\"color: blue;\"><b>#{char}</b></span>"
        end
      end)
    end)
    |> then(fn content ->
      case File.write(file_path, content) do
        :ok -> IO.puts("String written to file successfully.")
        {:error, reason} -> IO.puts("Failed to write to file: #{reason}")
      end
    end)
  end
end
