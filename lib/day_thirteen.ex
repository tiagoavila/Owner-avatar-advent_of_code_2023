defmodule DayThirteen do
  import Matrix, only: [transpose: 1]

  def part_one(input) do
    input
    |> String.split("\r\n\r\n", trim: true)
    |> Enum.map(&find_reflection_lines/1)
    |> Enum.reduce(0, &summarize/2)
  end

  def part_two(input) do
    400
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

  def find_smudge_and_replace(pattern) do
    pattern
    |> String.split("\r\n", trim: true)
    |> Enum.with_index()
    |> then(fn rows_list ->
      rows_list
      |> Enum.reduce_while([], fn {row, index}, acc ->
        rows_list
        |> Enum.drop(index + 1)
        |> Enum.reduce_while({}, fn {row2, _}, acc2 ->
          case find_smudge_index_in_row(row, row2) do
            {:found, smudge_index} -> {:halt, {:found, smudge_index}}
            _ -> {:cont, acc2}
          end
        end)
        |> then(fn result ->
          case result do
            {:found, smudge_index} ->
              <<previous::binary-size(smudge_index), char, rest::binary>> = row
              updated_row = previous <> replace_char(char) <> rest
              remaining_rows = Enum.drop(rows_list, index + 1) |> Enum.map(fn {row, _} -> row end)
              {:halt, Enum.reverse([updated_row | acc]) ++ remaining_rows}

            _ ->
              {:cont, [row | acc]}
          end
        end)
      end)
    end)
    |> Enum.join("\r\n")
  end

  defp replace_char(?#), do: "."
  defp replace_char(?.), do: "#"

  def find_smudge_index_in_row(row1, row2) do
    chars_row2 =
      row2
      |> String.graphemes()

    row1
    |> String.graphemes()
    |> then(&(&1 |> Enum.zip(chars_row2) |> Enum.with_index()))
    |> Enum.reduce_while({}, fn {{char1, char2}, index}, acc ->
      cond do
        char1 == char2 -> {:cont, acc}
        char1 != char2 && acc == {} -> {:cont, {:found, index}}
        char1 != char2 && acc != {} -> {:halt, :not_found}
      end
    end)
    |> then(fn result -> if result == {}, do: :equal, else: result end)
  end
end
