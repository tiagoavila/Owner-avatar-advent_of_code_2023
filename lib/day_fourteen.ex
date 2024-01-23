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
        rock == "." && idx == 0 -> {:halt, Map.update(acc, {idx, col_idx}, "O", fn _ -> "O" end)}
        rock == "." -> {:cont, acc}
        rock == "O" || rock == "#" -> {:halt, Map.update(acc, {idx + 1, col_idx}, "O", fn _ -> "O" end)}
      end
    end)
    |> then(fn acc ->
      Map.put_new(acc, {row_idx, col_idx}, ".")
    end)
  end
end
