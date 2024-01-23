defmodule DayFourteen do
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
    [:north, :west, :south, :east]
    |> Stream.cycle()
    |> Enum.take(1_000_000)
    |> Enum.reduce(input, fn direction, acc ->
      tilt_platform(acc, direction)
    end)
    |> IO.inspect(label: "DayFourteen - part two")

    64
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
