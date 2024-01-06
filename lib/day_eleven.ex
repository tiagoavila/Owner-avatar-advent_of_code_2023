defmodule DayEleven do
  def part_one(input) do
    {_, gallaxies_map} =
      input
      |> expand_gallaxy_image()
      |> Enum.with_index()
      |> Enum.reduce({0, %{}}, fn {line, row_index}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.filter(fn {char, _} -> char == "#" end)
        |> Enum.reduce(acc, fn {_, col_index}, {gallaxies_count, gallaxies_map} ->
          gallaxies_count = gallaxies_count + 1
          gallaxies_map = Map.put(gallaxies_map, gallaxies_count, {row_index, col_index})
          {gallaxies_count, gallaxies_map}
        end)
      end)

    Map.keys(gallaxies_map)
    |> Combination.combine(2)
    |> Enum.reduce(0, fn [gallaxy_a, gallaxy_b], acc ->
      {row_a, col_a} = Map.get(gallaxies_map, gallaxy_a)
      {row_b, col_b} = Map.get(gallaxies_map, gallaxy_b)

      # Calculate the Manhattan distance between the two gallaxies
      abs(row_b - row_a) + abs(col_b - col_a) + acc
    end)
  end

  def expand_gallaxy_image(input) do
    columns_count = hd(input) |> String.length()
    columns = MapSet.new(0..(columns_count - 1))

    input
    |> Enum.flat_map_reduce(columns, fn line, cols_acc ->
      if String.contains?(line, "#") do
        cols_acc =
          Regex.scan(~r/#/, line, return: :index)
          |> Enum.reduce(cols_acc, fn [{index, _}], acc ->
            MapSet.delete(acc, index)
          end)

        {[line], cols_acc}
      else
        {[line, line], cols_acc}
      end
    end)
    |> then(fn {updated_image, columns_without_gallaxy} ->
      columns_without_gallaxy_list =
        MapSet.to_list(columns_without_gallaxy)
        |> Enum.reverse()

      updated_image
      |> Enum.map(fn line ->
        Enum.reduce(columns_without_gallaxy_list, line, &duplicate_col_char/2)
      end)
    end)
  end

  defp duplicate_col_char(index, line) do
    <<previous::binary-size(index), char::binary-size(1), rest::binary>> = line
    previous <> char <> char <> rest
  end

  def part_two(input) do
  end
end
