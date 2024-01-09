defmodule DayEleven do
  def part_one(input, factor \\ 2) do
    {rows_without_gallaxy, cols_without_gallaxy} = get_rows_and_cols_without_gallaxies(input)

    gallaxies_map = input
    |> get_gallaxies_map()
    |> expand_gallaxies_map(rows_without_gallaxy, cols_without_gallaxy, factor)

    Map.keys(gallaxies_map)
    |> Combination.combine(2)
    |> Enum.reduce(0, fn [gallaxy_a, gallaxy_b], acc ->
      {row_a, col_a} = Map.get(gallaxies_map, gallaxy_a)
      {row_b, col_b} = Map.get(gallaxies_map, gallaxy_b)

      # Calculate the Manhattan distance between the two gallaxies
      abs(row_b - row_a) + abs(col_b - col_a) + acc
    end)
  end

  defp expand_gallaxies_map(gallaxies_map, rows_without_gallaxy, cols_without_gallaxy, factor) do
    gallaxies_map
    |> Enum.map(fn {gallaxy, {row, col}} ->
      no_gallaxy_count_before_row = rows_without_gallaxy
      |> Enum.count(fn row_without_gallaxy -> row_without_gallaxy < row end)

      no_gallaxy_count_before_col = cols_without_gallaxy
      |> Enum.count(fn col_without_gallaxy -> col_without_gallaxy < col end)

      row = row + (no_gallaxy_count_before_row * (factor - 1))
      col = col + (no_gallaxy_count_before_col * (factor - 1))

      {gallaxy, {row, col}}
    end)
    |> Map.new()
  end

  defp get_gallaxies_map(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce({0, %{}}, fn {row, row_index}, acc ->
      row
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {char, _} -> char == "#" end)
      |> Enum.reduce(acc, fn {_, col_index}, {gallaxies_count, gallaxies_map} ->
        gallaxies_count = gallaxies_count + 1
        gallaxies_map = Map.put(gallaxies_map, gallaxies_count, {row_index, col_index})
        {gallaxies_count, gallaxies_map}
      end)
    end)
    |> then(fn {_, gallaxies_map} -> gallaxies_map end)
  end

  def get_rows_and_cols_without_gallaxies(input) do
    columns_count = hd(input) |> String.length()
    columns = MapSet.new(0..(columns_count - 1))

    input
    |> Enum.with_index()
    |> Enum.reduce({[], columns}, fn {row, row_index}, {rows_acc, cols_acc} ->
      if String.contains?(row, "#") do
        cols_acc =
          Regex.scan(~r/#/, row, return: :index)
          |> Enum.reduce(cols_acc, fn [{index, _}], acc ->
            MapSet.delete(acc, index)
          end)

        {rows_acc, cols_acc}
      else
        {[row_index | rows_acc], cols_acc}
      end
    end)
    |> then(fn {rows_without_gallaxy, columns_without_gallaxy} ->
      {rows_without_gallaxy, MapSet.to_list(columns_without_gallaxy)}
    end)
  end

  def part_two(input, factor) do
    input
    |> part_one(factor)
  end
end
