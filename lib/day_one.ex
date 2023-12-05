defmodule DayOne do
  @regex_find_first_value ~r/^[a-zA-Z]*(\d)/
  @regex_find_last_value ~r/^.*(\d)/

  @regex_number_is_first ~r/^\d/
  @regex_number_is_last ~r/\d$/
  @regex_find_first_number_as_word ~r/(one|two|three|four|five|six|seven|eight|nine).*$/
  @regex_find_last_number_as_word ~r/^\w*(one|two|three|four|five|six|seven|eight|nine)/

  def get_sum_of_calibration_values(input) do
    input
    |> String.split("\r\n", trim: true)
    |> Enum.map(&get_calibration_values/1)
    |> Enum.sum()
  end

  def get_sum_of_calibration_values_part2(input) do
    input
    |> String.split("\r\n", trim: true)
    |> Enum.map(&get_calibration_values_with_number_words/1)
    |> Enum.sum()
  end

  defp get_calibration_values(input) do
    first_value =
      input
      |> get_first_value()

    last_value =
      input
      |> get_last_value()

    (first_value <> last_value)
    |> String.to_integer()
  end

  defp get_first_value(input) do
    [_, first_value] = Regex.run(@regex_find_first_value, input)
    first_value
  end

  defp get_last_value(input) do
    [_, last_value] = Regex.run(@regex_find_last_value, input)
    last_value
  end

  defp get_calibration_values_with_number_words(line) do
    first_value =
      line
      |> get_first_value_including_words()

    last_value =
      line
      |> get_last_value_including_words()

    (first_value <> last_value)
    |> String.to_integer()
  end

  defp get_first_value_including_words(line) do
    result = Regex.run(@regex_number_is_first, line)

    if result == nil, do: get_first_word_number(line), else: hd(result)
  end

  defp get_first_word_number(line) do
    result = Regex.run(@regex_find_first_number_as_word, line)
    if result == nil, do: get_first_value(line), else: tl(result) |> parse_word_to_string_number()
  end

  defp get_last_value_including_words(line) do
    result = Regex.run(@regex_number_is_last, line)

    if result == nil, do: get_last_word_number(line), else: hd(result)
  end

  defp get_last_word_number(line) do
    result = Regex.run(@regex_find_last_number_as_word, line)
    if result == nil, do: get_last_value(line), else: tl(result) |> parse_word_to_string_number()
  end

  defp parse_word_to_string_number(["one"]), do: "1"
  defp parse_word_to_string_number(["two"]), do: "2"
  defp parse_word_to_string_number(["three"]), do: "3"
  defp parse_word_to_string_number(["four"]), do: "4"
  defp parse_word_to_string_number(["five"]), do: "5"
  defp parse_word_to_string_number(["six"]), do: "6"
  defp parse_word_to_string_number(["seven"]), do: "7"
  defp parse_word_to_string_number(["eight"]), do: "8"
  defp parse_word_to_string_number(["nine"]), do: "9"

  def part2(input) do
    input
    |> replace_spelt_numbers()
    |> parse_input()
    |> Enum.map(&find_integers/1)
    |> Enum.sum()
  end

  def find_integers(line) do
    ints = Enum.filter(line, fn char -> char in ?0..?9 end)
    first = hd(ints)
    last = hd(Enum.reverse(ints))
    [first, last] |> List.to_integer()
  end

  # Ugly hack to consider stuff like "oneight" as "18"
  def replace_spelt_numbers("one" <> rest), do: "1" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("two" <> rest), do: "2" <> replace_spelt_numbers("o" <> rest)
  def replace_spelt_numbers("three" <> rest), do: "3" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("four" <> rest), do: "4" <> replace_spelt_numbers("r" <> rest)
  def replace_spelt_numbers("five" <> rest), do: "5" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("six" <> rest), do: "6" <> replace_spelt_numbers("x" <> rest)
  def replace_spelt_numbers("seven" <> rest), do: "7" <> replace_spelt_numbers("n" <> rest)
  def replace_spelt_numbers("eight" <> rest), do: "8" <> replace_spelt_numbers("t" <> rest)
  def replace_spelt_numbers("nine" <> rest), do: "9" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers(<<char, rest::binary>>), do: <<char>> <> replace_spelt_numbers(rest)
  def replace_spelt_numbers(""), do: ""

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end
end
