defmodule DayThirteen do
  import Matrix, only: [transpose: 1]

  def part_one(input) do
    input
    |> String.split("\r\n\r\n", trim: true)
    |> Enum.map(&find_reflection_lines/1)
    |> Enum.reduce(0, &summarize/2)
  end

  def part_two(input) do
  end

  defp summarize({:horizontal, row}, acc) do
    row * 100 + acc
  end

  defp summarize({:vertical, col}, acc) do
    col + acc
  end

  def find_reflection_lines(pattern) do
    horizontal_reflection =
      pattern
      |> find_reflection()

    case horizontal_reflection do
      {row1, _row2} ->
        {:horizontal, row1}

      :not_found ->
        vertical_reflection =
          pattern
          |> transpose_pattern()
          |> find_reflection()

        case vertical_reflection do
          {col1, _col2} -> {:vertical, col1}
          :not_found -> {}
        end
    end
  end

  def transpose_pattern(pattern) do
    pattern
    |> String.split("\r\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> transpose()
    |> Enum.map_join("\r\n", &Enum.join/1)
  end

  def find_reflection(input) do
    rows_list =
      input
      |> String.split("\r\n", trim: true)
      |> Enum.with_index(1)

    rows_list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [{row_one, index_one}, {row_two, _}] ->
      row_one == row_two && is_reflection_pattern_valid?(rows_list, index_one)
    end)
    |> then(fn reflection_rows ->
      case reflection_rows do
        [] ->
          :not_found

        _ ->
          [[{_, index_one}, {_, index_two}]] = reflection_rows
          {index_one, index_two}
      end
    end)
  end

  defp is_reflection_pattern_valid?(rows, index_one) do
    {list_one, list_two} = Enum.split_while(rows, fn {_, index} -> index <= index_one end)

    list_one
    |> Enum.sort(fn {_, index_one}, {_, index_two} -> index_one > index_two end)
    |> then(&(&1 |> Enum.zip(list_two)))
    |> Enum.all?(fn {{row_one, _}, {row_two, _}} -> row_one == row_two end)
  end
end
