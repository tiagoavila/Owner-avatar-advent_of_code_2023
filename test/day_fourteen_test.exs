defmodule DayFourteenTest do
  use ExUnit.Case

	# @tag skip: true
  test "DayFourteen - test part one" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part_one() == 136
  end

  test "Tilt Platform To North" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform_to_north()
           |> then(fn platform_map ->
             for row <- 0..9, into: [] do
               for col <- 0..9 do
                 Map.get(platform_map, {row, col}, ".")
               end
             end
             |> Enum.map_join(",", fn row -> row |> Enum.join() end)
           end)
          == "OOOO.#.O..,OO..#....#,OO..O##..O,O..#.OO...,........#.,..#....#.#,..O..#.O.O,..O.......,#....###..,#....#...."
  end

  test "DayFourteen - challenge part one" do
  assert File.read!("./inputs/day_fourteen/challenge_input.txt")
         |> String.split("\r\n", trim: true)
         |> DayFourteen.part_one()
         |> IO.inspect(label: "DayFourteen - challenge one")
  end

  # test "DayFourteen - test part two" do
  # 	assert File.read!("./inputs/day_fourteen/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayFourteen.part_two() == 0
  # end

  # test "DayFourteen - challenge part two" do
  # 	assert File.read!("./inputs/day_fourteen/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayFourteen.part_two()
  # 	   |> IO.inspect(label: "day_fourteen - challenge two")
  # end
end
