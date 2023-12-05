defmodule DayTwo do
  def part_one(input) do
    input
    |> Enum.map(&parse_game_row/1)
		|> IO.inspect(label: "Day 02 - challenge one")
    |> Enum.filter(&(&1 != -1))
		|> Enum.sum()
  end

  defp parse_game_row(row) do
    [<<"Game ", game_number::binary>>, plays] = row |> String.split(":", trim: true)

    all_cube_counts_are_valid =
      plays
      |> String.split(";", trim: true)
      |> Enum.all?(&check_plays_in_a_game/1)

    if all_cube_counts_are_valid == true, do: game_number |> String.to_integer(), else: -1
  end

  defp check_plays_in_a_game(play) do
    play
    |> String.split(",", trim: true)
    |> Enum.map(&parse_play/1)
    |> Enum.all?(&validate_cube/1)
  end

  defp parse_play(play) do
    play
    |> String.trim()
    |> String.split()
  end

  defp validate_cube([cube_count, "red"]), do: cube_count |> String.to_integer() <= 12
  defp validate_cube([cube_count, "green"]), do: cube_count |> String.to_integer() <= 13
  defp validate_cube([cube_count, "blue"]), do: cube_count |> String.to_integer() <= 14
end
