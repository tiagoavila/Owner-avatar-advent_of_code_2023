defmodule AoC2023.Day12 do
  import DayTwelve, only: [parse: 1]

@moduledoc """
  Documentation for `AocDayTwelve`.
  """

  # `input` for both parts are things like
  #
  # [
  #   {"#.#.###", [1,1,3]},
  #   {".#...#....###.", [1,1,3]},
  #   ...
  # ]

  @spec part1([{String.t(), [pos_integer()]}]) :: non_neg_integer()
  def part1(input) do
    input
    |> Task.async_stream(
      fn {springs, counters} ->
        # It does not change the result
        # if we prepend a "." to each line of springs.
        # By adding this "." I do not need to handle the
        # edge case that the line starts with a "?".
        aux(springs, 0, ".", counters, %{})
      end,
      ordered: false
    )
    |> Stream.map(&elem(&1, 1))
    |> Stream.map(&elem(&1, 0))
    |> Enum.sum()
  end

  @spec part2([String.t()]) :: non_neg_integer()
  def part2(input) do
    input
    |> Enum.map(&parse/1)
    |> Enum.map(fn {springs, counters} ->
      {
        List.duplicate(springs, 5) |> Enum.join("?"),
        List.duplicate(counters, 5) |> List.flatten()
      }
    end)
    |> part1()
  end

  @spec aux(
          springs :: String.t(),
          index,
          previous_spring :: String.t(),
          counters,
          memo
        ) :: {total_count, memo}
        when index: non_neg_integer(),
             counters: [non_neg_integer()],
             total_count: non_neg_integer(),
             memo: %{optional({index, counters}) => total_count}

  # When we reached the end of a line,
  # and all counters are consumed,
  # we found a solution.
  def aux("", _, _, [], memo), do: {1, memo}

  # When we reached the end of a line,
  # and the last counter reaches 0,
  # we found a solution.
  def aux("", _, _, [0], memo), do: {1, memo}

  # When we reached the end of a line,
  # and there is at least one non-zero counter,
  # that's an invalid situation so no solution.
  def aux("", _, _, _, memo), do: {0, memo}

  # When the current spring is broken,
  # and there is no counter left,
  # that's an invalid situation so no solution.
  def aux("#" <> _, _, _, [], memo), do: {0, memo}

  # When the current spring is broken,
  # and the current counter reaches 0,
  # that's an invalid situation so no solution.
  def aux("#" <> _, _, _, [0 | _], memo), do: {0, memo}

  # When the current spring is broken,
  # and the current counter is not 0,
  # decrement the counter and recursively find solutions.
  def aux("#" <> rest, i, _, [h | t], memo), do: aux(rest, i + 1, "#", [h - 1 | t], memo)

  # When the current spring is good,
  # and there's no counter left,
  # try rest of the line and see if all the springs left are good.
  def aux("." <> rest, i, _, [], memo), do: aux(rest, i + 1, ".", [], memo)

  # When the current spring is good,
  # and the previous spring is bad,
  # and the current counter reaches 0,
  # we can discard that 0 and recursively find solutions.
  def aux("." <> rest, i, "#", [0 | t], memo), do: aux(rest, i + 1, ".", t, memo)

  # When the current spring is good,
  # and the previous spring is bad,
  # and the current counter is not 0,
  # that's an invalid situation so no solution.
  def aux("." <> _, _, "#", [_ | _], memo), do: {0, memo}

  # When the current spring is good,
  # and the previous spring is also good,
  # and the current counter is not 0,
  # just check the rest of the springs.
  def aux("." <> rest, i, ".", counters, memo), do: aux(rest, i + 1, ".", counters, memo)

  # When the current spring is unknown,
  # and the previous spring is broken,
  # and there's no counter left,
  # then the current spring has to be good.
  # We still need to check the rest of the springs.
  def aux("?" <> rest, i, "#", [], memo), do: aux(rest, i + 1, ".", [], memo)

  # When the current spring is unknown,
  # and the previous spring is broken,
  # and the current counter reaches 0,
  # then the current spring has to be good.
  # We still need to check the rest of the springs.
  # The zero-counter is no longer useful so we discard it.
  def aux("?" <> rest, i, "#", [0 | t], memo), do: aux(rest, i + 1, ".", t, memo)

  # When the current spring is unknown,
  # and the previous spring is bad,
  # and the current counter is not 0,
  # then the current spring has to be broken.
  # We decrement that counter and check the rest of the springs.
  def aux("?" <> rest, i, "#", [h | t], memo), do: aux(rest, i + 1, "#", [h - 1 | t], memo)

  # When the current spring is unknown,
  # and the previous spring is good,
  # and there's no counter left,
  # then the current spring has to be good.
  # We still need to check the rest of the springs.
  def aux("?" <> rest, i, ".", [], memo), do: aux(rest, i + 1, ".", [], memo)

  # When the current spring is unknown,
  # and the previous spring is good,
  # and the current counter reaches 0,
  # then the current spring must be good.
  # Discard the 0 counter as usual,
  # and check the rest of the springs.
  def aux("?" <> rest, i, ".", [0 | t], memo), do: aux(rest, i + 1, ".", t, memo)

  # When the current spring is unknown,
  # and the previous spring is good,
  # and the current counter is not 0,
  # then the current spring can be either good or bad.
  # Try both possibilities.
  def aux("?" <> rest, i, ".", [h | t], memo) do
    memoized(memo, {i, [h | t]}, fn ->
      {a, memo} = aux(rest, i + 1, "#", [h - 1 | t], memo)
      {b, memo} = aux(rest, i + 1, ".", [h | t], memo)
      {a + b, memo}
    end)
  end

  def memoized(memo, key, fun) do
    with nil <- Map.get(memo, key) do
      {result, memo} = fun.()
      memo = Map.put(memo, key, result)
      {result, memo}
    else
      result -> {result, memo}
    end
  end

end
