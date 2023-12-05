defmodule DayThree do
  alias DayThree.{Accumulator, NumberPosition}

  @invalid_symbols ~w(. 0 1 2 3 4 5 6 7 8 9)
  @numbers ~w(0 1 2 3 4 5 6 7 8 9)

  def part_one(input) do
    input
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      row
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.map(fn {char, col_index} ->
        {row_index, col_index, char}
      end)
    end)
    |> Enum.reduce(%Accumulator{}, fn {row_index, col_index, char},
                                      %{is_previous_a_valid_symbol: is_previous_a_valid_symbol} =
                                        acc ->
      case char |> get_char_type() do
        :valid_symbol when acc.is_previous_a_number ->
          %{
            acc
            | valid_symbols: Map.put(acc.valid_symbols, {row_index, col_index}, char),
              is_previous_a_valid_symbol: true,
              is_previous_a_number: false,
              previous: "",
              numbers: [
                %NumberPosition{number: String.to_integer(acc.previous), is_part_number: true}
                | acc.numbers
              ]
          }

        :valid_symbol ->
          %{
            acc
            | valid_symbols: Map.put(acc.valid_symbols, {row_index, col_index}, char),
              is_previous_a_valid_symbol: true,
              is_previous_a_number: false,
              previous: ""
          }

        :number
        when acc.is_previous_a_number == false and acc.is_previous_a_valid_symbol == false ->
          %{
            acc
            | previous: char,
              is_previous_a_number: true
          }

        :number when acc.is_previous_a_number == true ->
          %{
            acc
            | previous: acc.previous <> char,
              is_previous_a_number: true,
              is_previous_a_valid_symbol: false
          }

        :number when acc.is_previous_a_valid_symbol == true ->
          %{
            acc
            | add_number_as_valid: true,
              is_previous_a_number: true,
              is_previous_a_valid_symbol: false,
              previous: char
          }

        :invalid_symbol when acc.is_previous_a_number == true ->
          %{
            acc
            | numbers: [%NumberPosition{number: String.to_integer(acc.previous), is_part_number: acc.add_number_as_valid} | acc.numbers],
              is_previous_a_number: false,
							add_number_as_valid: false,
              previous: ""
          }

        _ ->
          acc
      end
    end)
    |> IO.inspect(label: "Day 03 - challenge one")

    # |> Map.new(fn {row_index, col_index, char} ->
    # 	{{row_index, col_index}, char}
    # end)

    4361
  end

  defp get_char_type(char) do
    cond do
      char |> is_valid_symbol?() -> :valid_symbol
      char |> is_number?() -> :number
      true -> :invalid_symbol
    end
  end

  defp is_valid_symbol?(char), do: char not in @invalid_symbols
  defp is_number?(char), do: char in @numbers
end
