defmodule AoC2023.Day12 do

  # `input` for both parts are things like
  #
  # [
  #   {"???.###", [1,1,3]},
  #   {".??..??...###.", [1,1,3]},
  #   ...
  # ]

  @spec part1([{String.t(), [pos_integer()]}]) :: non_neg_integer()
  def part1(input) do
    input
    |> Task.async_stream(fn {springs, counts} ->
      aux(springs, ".", counts)
    end, ordered: false)
    |> Stream.map(&elem(&1, 1))
    |> Enum.sum()
  end

  @spec part2([{String.t(), [pos_integer()]}]) :: non_neg_integer()
  def part2(input) do
    input
    |> Enum.map(fn {springs, counts} ->
      {
        List.duplicate(springs, 5) |> Enum.join("?"),
        List.duplicate(counts, 5) |> List.flatten()
      }
    end)
    |> part1()
  end

  @spec aux(
    springs :: String.t(),
    previous_spring :: String.t(),
    counts :: [pos_integer()]
  ) :: non_neg_integer()
  defp aux("", _, []), do: 1

  defp aux("", _, [0]), do: 1

  defp aux("", _, _), do: 0

  defp aux("#" <> _, _, []), do: 0

  defp aux("#" <> _, _, [0 | _]), do: 0

  defp aux("#" <> rest, _, [h | t]), do: aux(rest, "#", [h - 1 | t])

  defp aux("." <> rest, _, []), do: aux(rest, ".", [])

  defp aux("." <> rest, "#", [0 | t]), do: aux(rest, ".", t)

  defp aux("." <> _, "#", [_ | _]), do: 0

  defp aux("." <> rest, ".", counts), do: aux(rest, ".", counts)

  defp aux("?" <> rest, "#", []), do: aux(rest, ".", [])

  defp aux("?" <> rest, "#", [0 | t]), do: aux(rest, ".", t)

  defp aux("?" <> rest, "#", [h | t]), do: aux(rest, "#", [h - 1 | t])

  defp aux("?" <> rest, ".", []), do: aux(rest, ".", [])

  defp aux("?" <> rest, ".", [0 | t]), do: aux(rest, ".", t)

  defp aux("?" <> rest, ".", [h | t]) do
    memoized({rest, [h | t]}, fn ->
      aux(rest, "#", [h - 1 | t]) + aux(rest, ".", [h | t])
    end)
  end

  defp memoized(key, fun) do
    with nil <- Process.get(key) do
      fun.() |> tap(&Process.put(key, &1))
    end
  end
end
