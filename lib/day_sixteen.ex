defmodule DaySixteen do
  @top {-1, 0}
  @right {0, 1}
  @bottom {1, 0}
  @left {0, -1}

  def part_one(input) do
    input
    |> parse_to_map()
    |> then(fn tiles_map ->
      process_beam(tiles_map[{0, 0}], {0, 0}, @right, tiles_map, [], MapSet.new())
    end)
    |> Enum.count()
  end

  def part_two(input) do
  end

  defp parse_to_map(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row_idx}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.into(acc, fn {char, col_idx} ->
        {{row_idx, col_idx}, char}
      end)
    end)
  end

  defp process_beam(nil, _, _, _, [], visited), do: visited

  defp process_beam(nil, _, _, tiles_map, queue, visited) do
    [{row, col, dir} | tail] = queue
    next_tile_pos = get_next_tile_pos({row, col}, dir)

    process_beam(
      Map.get(tiles_map, next_tile_pos),
      next_tile_pos,
      dir,
      tiles_map,
      tail,
      visited
    )
  end

  defp process_beam("|", {row, col}, dir, tiles_map, queue, visited)
       when dir == @right or dir == @left do
    if MapSet.member?(visited, {row, col}) do
      process_beam(nil, nil, nil, tiles_map, queue, visited)
    else
      queue = [Tuple.append({row, col}, @bottom) | queue]
      visited = MapSet.put(visited, {row, col})
      next_tile_pos = get_next_tile_pos({row, col}, @top)

      process_beam(
        Map.get(tiles_map, next_tile_pos),
        next_tile_pos,
        @top,
        tiles_map,
        queue,
        visited
      )
    end
  end

  defp process_beam("-", {row, col}, dir, tiles_map, queue, visited)
       when dir == @top or dir == @bottom do
    if MapSet.member?(visited, {row, col}) do
      process_beam(nil, nil, nil, tiles_map, queue, visited)
    else
      queue = [Tuple.append({row, col}, @left) | queue]
      visited = MapSet.put(visited, {row, col})
      next_tile_pos = get_next_tile_pos({row, col}, @right)

      process_beam(
        Map.get(tiles_map, next_tile_pos),
        next_tile_pos,
        @right,
        tiles_map,
        queue,
        visited
      )
    end
  end

  defp process_beam("/", {row, col}, dir, tiles_map, queue, visited) do
    visited = MapSet.put(visited, {row, col})

    next_direction =
      case dir do
        @right -> @top
        @left -> @bottom
        @top -> @right
        @bottom -> @left
      end

    next_tile_pos = get_next_tile_pos({row, col}, next_direction)

    process_beam(
      Map.get(tiles_map, next_tile_pos),
      next_tile_pos,
      next_direction,
      tiles_map,
      queue,
      visited
    )
  end

  defp process_beam("\\", {row, col}, dir, tiles_map, queue, visited) do
    visited = MapSet.put(visited, {row, col})

    next_direction =
      case dir do
        @right -> @bottom
        @left -> @top
        @top -> @left
        @bottom -> @right
      end

    next_tile_pos = get_next_tile_pos({row, col}, next_direction)

    process_beam(
      Map.get(tiles_map, next_tile_pos),
      next_tile_pos,
      next_direction,
      tiles_map,
      queue,
      visited
    )
  end

  defp process_beam(_, current_pos, direction, tiles_map, queue, visited) do
    visited = MapSet.put(visited, current_pos)
    next_tile_pos = get_next_tile_pos(current_pos, direction)

    process_beam(
      Map.get(tiles_map, next_tile_pos),
      next_tile_pos,
      direction,
      tiles_map,
      queue,
      visited
    )
  end

  defp get_next_tile_pos({row, col}, {row_dir, col_dir}), do: {row + row_dir, col + col_dir}
end
