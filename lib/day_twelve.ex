defmodule DayTwelve do
  def part_one(input) do
    input
    |> Task.async_stream(fn spring_and_counts ->
      [spring_line, damaged_groups_string] = String.split(spring_and_counts, " ", trim: true)

      damaged_groups =
        damaged_groups_string
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)

      count_valid_combinations(spring_line, damaged_groups)
    end)
    |> Enum.reduce(0, fn {:ok, count}, acc -> count + acc end)
  end

  def generate_all_combinations(spring_line) do
    do_generate_all_combinations(spring_line)
  end

  defp do_generate_all_combinations(spring_line, combination \\ "", combinations \\ [])

  defp do_generate_all_combinations("", combination, combinations),
    do: [combination | combinations]

  defp do_generate_all_combinations(<<"?", rest::binary>>, combination, combinations) do
    # memoized(rest, fn ->
    #   do_generate_all_combinations(rest, combination <> "#", combinations) ++
    #     do_generate_all_combinations(rest, combination <> ".", combinations)
    # end)

    do_generate_all_combinations(rest, combination <> "#", combinations) ++
      do_generate_all_combinations(rest, combination <> ".", combinations)
  end

  defp do_generate_all_combinations(
         <<char::binary-size(1), rest::binary>> = rem,
         combination,
         combinations
       ) do
    case String.contains?(rest, "?") do
      true -> do_generate_all_combinations(rest, combination <> char, combinations)
      false -> [combination <> rem | combinations]
    end
  end

  defp memoized(key, fun) do
    with nil <- Process.get(key) do
      fun.() |> tap(&Process.put(key, &1))
    end
  end

  def validate_combination(spring_line, damaged_groups) do
    damaged_in_line = Regex.scan(~r/#+/, spring_line, return: :index)

    cond do
      length(damaged_groups) != length(damaged_in_line) -> false
      Enum.map(damaged_in_line, fn [{_, count}] -> count end) == damaged_groups -> true
      true -> false
    end
  end

  def count_valid_combinations(spring_line, damaged_groups) do
    generate_all_combinations(spring_line)
    |> Enum.count(&validate_combination(&1, damaged_groups))
  end

  def part_two(input) do
  end
end
