defmodule AoC2023.Day17 do
  @spec part1(%{coord => loss}) :: total_loss
        when coord: {i :: non_neg_integer(), j :: non_neg_integer()},
             loss: pos_integer(),
             total_loss: pos_integer()
  def part1(grid) do
    {dest, _} = Enum.max(grid)

    :gb_sets.empty()
    |> enqueue({grid[{0, 1}], {{0, 1}, {0, 1, 1}}})
    |> enqueue({grid[{1, 0}], {{1, 0}, {1, 0, 1}}})
    |> total_loss_p1(
      grid,
      dest,
      MapSet.new([
        {{0, 1}, {0, 1, 1}},
        {{1, 0}, {1, 0, 1}}
      ])
    )
  end

  @spec part2(%{coord => loss}) :: total_loss
        when coord: {i :: non_neg_integer(), j :: non_neg_integer()},
             loss: pos_integer(),
             total_loss: pos_integer()
  def part2(grid) do
    {dest, _} = Enum.max(grid)

    :gb_sets.empty()
    |> enqueue({grid[{0, 1}], {{0, 1}, {0, 1, 1}}})
    |> enqueue({grid[{1, 0}], {{1, 0}, {1, 0, 1}}})
    |> total_loss_p2(
      grid,
      dest,
      MapSet.new([
        {{0, 1}, {0, 1, 1}},
        {{1, 0}, {1, 0, 1}}
      ])
    )
  end

  defp total_loss_p1(pq, grid, {max_i, max_j} = dest, seen) do
    case :gb_sets.take_smallest(pq) do
      {{loss, {{^max_i, ^max_j}, _}}, _pq} ->
        loss

      {{loss, {{i, j}, {di, dj, steps}}}, pq} ->
        {i2, j2} = {i + dj, j - di}
        pds = {{i2, j2}, {dj, -di, 1}}

        {pq, seen} =
          if i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        {i2, j2} = {i - dj, j + di}
        pds = {{i2, j2}, {-dj, di, 1}}

        {pq, seen} =
          if i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        {i2, j2} = {i + di, j + dj}
        pds = {{i2, j2}, {di, dj, steps + 1}}

        {pq, seen} =
          if steps < 3 and i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        total_loss_p1(pq, grid, dest, seen)
    end
  end

  defp total_loss_p2(pq, grid, {max_i, max_j} = dest, seen) do
    case :gb_sets.take_smallest(pq) do
      {{loss, {{^max_i, ^max_j}, {_, _, steps}}}, _pq} when steps >= 4 ->
        loss

      {{loss, {{i, j}, {di, dj, steps}}}, pq} ->
        {i2, j2} = {i + dj, j - di}
        pds = {{i2, j2}, {dj, -di, 1}}

        {pq, seen} =
          if steps >= 4 and i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        {i2, j2} = {i - dj, j + di}
        pds = {{i2, j2}, {-dj, di, 1}}

        {pq, seen} =
          if steps >= 4 and i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        {i2, j2} = {i + di, j + dj}
        pds = {{i2, j2}, {di, dj, steps + 1}}

        {pq, seen} =
          if steps < 10 and i2 in 0..max_i and j2 in 0..max_j and pds not in seen do
            {enqueue(pq, {grid[{i2, j2}] + loss, pds}), MapSet.put(seen, pds)}
          else
            {pq, seen}
          end

        total_loss_p2(pq, grid, dest, seen)
    end
  end

  defp enqueue(pq, item) do
    :gb_sets.insert(item, pq)
  end
end
