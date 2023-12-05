defmodule DayTwo do
  def part_one(input) do
    input
    |> Enum.map(&get_possible_games/1)
    |> Enum.filter(&(&1 != -1))
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> Enum.map(&get_minimum_set_of_cubes_by_game/1)
    |> Enum.reduce(0, fn %{red: red_count, green: green_count, blue: blue_count}, acc ->
      acc + red_count * green_count * blue_count
    end)
  end

  defp get_possible_games(row) do
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

  defp get_minimum_set_of_cubes_by_game(game) do
    [_, plays] = game |> String.split(":", trim: true)

    plays
    |> String.split(";", trim: true)
    |> Enum.flat_map(&parse_plays_to_list_of_tuples/1)
    |> Enum.reduce(%{red: 0, green: 0, blue: 0}, &find_minimum_cubes/2)
  end

  defp parse_plays_to_list_of_tuples(play) do
    play
    |> String.split(",", trim: true)
    |> Enum.map(&(String.split(&1) |> List.to_tuple()))
  end

  defp find_minimum_cubes({cube_count, "red"}, %{red: red_count} = acc) do
    cube_count_parsed = cube_count |> String.to_integer()

    if cube_count_parsed > red_count do
      %{acc | red: cube_count_parsed}
    else
      acc
    end
  end

  defp find_minimum_cubes({cube_count, "green"}, %{green: green_count} = acc) do
    cube_count_parsed = cube_count |> String.to_integer()

    if cube_count_parsed > green_count do
      %{acc | green: cube_count_parsed}
    else
      acc
    end
  end

  defp find_minimum_cubes({cube_count, "blue"}, %{blue: blue_count} = acc) do
    cube_count_parsed = cube_count |> String.to_integer()

    if cube_count_parsed > blue_count do
      %{acc | blue: cube_count_parsed}
    else
      acc
    end
  end
end
