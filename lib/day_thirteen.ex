defmodule DayThirteen do
  def part_one(input) do
    405
  end

  def part_two(input) do
  end

  def find_reflection_rows(input) do
    rows_list =
      input
      |> String.split("\r\n", trim: true)
      |> Enum.with_index(1)

    reflection_rows =
      rows_list
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.filter(fn [{row_one, _}, {row_two, _}] ->
        row_one == row_two
      end)
      |> then(fn reflection_rows ->
        case reflection_rows do
          [] ->
            {}

          _ ->
            [[{_, index_one}, {_, index_two}]] = reflection_rows
            {index_one, index_two}
        end
      end)

    if reflection_rows != {} do
      is_reflection_pattern_valid?(rows_list, reflection_rows)
      |> then(fn result ->
        case result do
          true -> reflection_rows
          false -> {}
        end
      end)
    else
      {}
    end
  end

  defp is_reflection_pattern_valid?(rows, {index_one, _}) do
    {list_one, list_two} = Enum.split_while(rows, fn {_, index} -> index <= index_one end)

    list_one
    |> Enum.sort(fn {_, index_one}, {_, index_two} -> index_one > index_two end)
    |> then(&(&1 |> Enum.zip(list_two)))
    |> Enum.all?(fn {{row_one, _}, {row_two, _}} -> row_one == row_two end)
  end
end
