defmodule DayFourteen do
  @cycle_count 1_000_000_000

  def part_one(input) do
    input
    |> tilt_platform_to_north()
    |> Enum.reduce(0, fn {{row, _}, rock}, acc ->
      case rock do
        "O" -> length(input) - row + acc
        _ -> acc
      end
    end)
  end

  def part_two(input) do
    key = Murmur.hash_x86_32(input)
    Process.put(key, 0)

    1..@cycle_count
    |> Enum.reduce_while(input, fn count, acc ->
      result = cycle(acc)
      key = Murmur.hash_x86_32(result)

      case Process.get(key) do
        nil ->
          result
          |> tap(fn _ -> Process.put(key, count) end)
          |> then(fn result -> {:cont, result} end)

        loop_start ->
          {:halt, {loop_start, count}}
      end
    end)
    |> then(fn {loop_start, loop_end} ->
      cycle_until_beginning_of_loop = apply_cycles(input, loop_start)

      cycles_left = @cycle_count - loop_start

      diff = loop_end - loop_start # number of cycles until loop repeats
      cycles_left = rem(cycles_left, diff)

      apply_cycles(cycle_until_beginning_of_loop, cycles_left)
    end)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, index}, acc ->
      row
      |> String.graphemes()
      |> Enum.count(&(&1 == "O"))
      |> then(fn rock_count ->
        (length(input) - index) * rock_count
      end)
      |> Kernel.+(acc)
    end)
  end

  def apply_cycles(input, count) do
    1..count
    |> Enum.reduce(input, fn _, acc -> cycle(acc) end)
  end

  def cycle(input) do
    tilt_platform(input, :north)
    |> tilt_platform(:west)
    |> tilt_platform(:south)
    |> tilt_platform(:east)
  end

  def tilt_platform_to_north(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {row, row_idx}, acc ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col_idx}, acc ->
        case char do
          "." -> Map.put(acc, {row_idx, col_idx}, char)
          "#" -> Map.put(acc, {row_idx, col_idx}, char)
          "O" -> roll_rock_to_north({row_idx, col_idx}, acc)
        end
      end)
    end)
  end

  defp roll_rock_to_north({0, col_idx}, acc) do
    Map.put(acc, {0, col_idx}, "O")
  end

  defp roll_rock_to_north({row_idx, col_idx}, acc) do
    (row_idx - 1)..0//-1
    |> Enum.reduce_while(acc, fn idx, acc ->
      rock = Map.get(acc, {idx, col_idx})

      cond do
        rock == "." && idx == 0 ->
          {:halt, Map.update(acc, {idx, col_idx}, "O", fn _ -> "O" end)}

        rock == "." ->
          {:cont, acc}

        rock == "O" || rock == "#" ->
          {:halt, Map.update(acc, {idx + 1, col_idx}, "O", fn _ -> "O" end)}
      end
    end)
    |> then(fn acc ->
      Map.put_new(acc, {row_idx, col_idx}, ".")
    end)
  end

  def part1_really_cool_approach(input) do
    input
    |> Enum.map(&String.graphemes/1)
    |> List.zip()
    |> Enum.reduce(0, fn column, acc ->
      column
      |> Tuple.to_list()
      |> Enum.chunk_by(&(&1 == "#"))
      |> Enum.flat_map(&Enum.sort(&1, :desc))
      |> Enum.with_index(0)
      |> then(
        &for {"O", n} <- &1, reduce: 0 do
          acc -> acc + (length(input) - n)
        end
      )
      |> Kernel.+(acc)
    end)
  end

  @spec tilt_platform(any(), :east | :north | :south | :west) :: list()
  def tilt_platform(input, direction) do
    sorter =
      case direction do
        :north -> :desc
        :south -> :asc
        :west -> :desc
        :east -> :asc
      end

    input
    |> Enum.map(&String.graphemes/1)
    |> then(&rotate_if_needed(&1, direction))
    |> Enum.map(fn column ->
      column
      |> Enum.chunk_by(&(&1 == "#"))
      |> Enum.flat_map(fn column ->
        if column == ["#"], do: column, else: Enum.sort(column, sorter)
      end)
    end)
    |> then(&rotate_if_needed(&1, direction))
    |> Enum.map(&Enum.join/1)
  end

  defp rotate_if_needed(rows, direction) when direction == :north or direction == :south do
    rows |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  defp rotate_if_needed(rows, _), do: rows
end
