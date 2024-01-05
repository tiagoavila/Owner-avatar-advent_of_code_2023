defmodule DayEleven do
  def part_one(input) do
    374
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
