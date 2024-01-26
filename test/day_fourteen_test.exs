defmodule DayFourteenTest do
  use ExUnit.Case

  @tag skip: true
  test "DayFourteen - test part one" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part_one() == 136
  end

  @tag skip: true
  test "DayFourteen - test part one really cool approach" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part1_really_cool_approach() == 136
  end

  @tag skip: true
  test "Tilt Platform To North - Map version" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform(:north)
           |> then(fn platform_map ->
             for row <- 0..9, into: [] do
               for col <- 0..9 do
                 Map.get(platform_map, {row, col}, ".")
               end
             end
             |> Enum.map_join(",", fn row -> row |> Enum.join() end)
           end) ==
             "OOOO.#.O..,OO..#....#,OO..O##..O,O..#.OO...,........#.,..#....#.#,..O..#.O.O,..O.......,#....###..,#....#...."
  end

  @tag skip: true
  test "Tilt Platform To North" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform(:north)
           |> Enum.join(",") ==
             "OOOO.#.O..,OO..#....#,OO..O##..O,O..#.OO...,........#.,..#....#.#,..O..#.O.O,..O.......,#....###..,#....#...."
  end

  @tag skip: true
  test "Tilt Platform To West" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform(:west)
           |> Enum.join(",") ==
             "O....#....,OOO.#....#,.....##...,OO.#OO....,OO......#.,O.#O...#.#,O....#OO..,O.........,#....###..,#OO..#...."
  end

  @tag skip: true
  test "Tilt Platform To South" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform(:south)
           |> Enum.join(",") ==
             ".....#....,....#....#,...O.##...,...#......,O.O....O#O,O.#..O.#.#,O....#....,OO....OO..,#OO..###..,#OO.O#...O"
  end

  @tag skip: true
  test "Tilt Platform To East" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.tilt_platform(:east)
           |> Enum.join(",") ==
             "....O#....,.OOO#....#,.....##...,.OO#....OO,......OO#.,.O#...O#.#,....O#..OO,.........O,#....###..,#..OO#...."
  end

  @tag skip: true
  test "DayFourteen - challenge part one" do
    assert File.read!("./inputs/day_fourteen/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part_one()
           |> IO.inspect(label: "DayFourteen - challenge one")
  end

  @tag skip: true
  test "DayFourteen - test part two" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
    |> String.split("\r\n", trim: true)
    |> DayFourteen.part_two() == 64
  end

  @tag skip: true
  test "DayFourteen - test part two from ElixirForum" do
    assert File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> AoC2023Day14.parse_input()
           |> AoC2023Day14.part_two() == 64
  end

  @tag skip: true
  test "DayFourteen - challenge part two" do
  	assert File.read!("./inputs/day_fourteen/challenge_input.txt")
  	   |> String.split("\r\n", trim: true)
  	   |> DayFourteen.part_two()
  	   |> IO.inspect(label: "day_fourteen - challenge two")
  end
end
