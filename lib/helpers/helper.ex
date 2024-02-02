defmodule Helper do
  def parse_list_of_lists_to_map(input, parser_function \\ &(&1)) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row_idx}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.into(acc, fn {char, col_idx} ->
        {{row_idx, col_idx}, parser_function.(char)}
      end)
    end)
  end
end
