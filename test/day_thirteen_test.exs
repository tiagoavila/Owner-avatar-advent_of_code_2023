defmodule DayThirteenTest do
  use ExUnit.Case

  # @tag skip: true
  test "DayThirteen - test part one" do
    assert File.read!("./inputs/day_thirteen/test_input.txt")
           |> DayThirteen.part_one() == 405
  end

  @tag skip: true
  test "Find reflection horizontal pattern" do
    input = """
    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

    assert DayThirteen.find_reflection(input) == {4, 5}
  end

  @tag skip: true
  test "Find reflection vertical pattern" do
    input = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.
    """

    assert input
           |> DayThirteen.transpose_pattern()
           |> DayThirteen.find_reflection() == {5, 6}
  end

  @tag skip: true
  test "Find reflection in challenge sample" do
    input = """
    ##.####.#
    .###.####
    ###...###
    ###...###
    .###.####
    #..####.#
    ..###..#.
    ##..#..#.
    ####...#.
    #....#.#.
    ...#.....
    #....#.##
    #.#.#.##.
    #.#.#.##.
    #....#.##
    ...#.....
    #....#.#.
    """

    assert DayThirteen.find_reflection(input) |> IO.inspect(label: "reflection rows")
  end

  @tag skip: true
  test "DayThirteen - challenge part one" do
    assert File.read!("./inputs/day_thirteen/challenge_input.txt")
           |> DayThirteen.part_one()
           |> IO.inspect(label: "DayThirteen - challenge one")
  end

  # @tag skip: true
  test "Find Smudge row" do
    row1 = "#...##..#"
    row2 = "#....#..#"
    assert DayThirteen.find_smudge_index_in_row(row1, row2) == {:found, 4}

    row1 = "#.##..##."
    row2 = "..##..##."
    assert DayThirteen.find_smudge_index_in_row(row1, row2) == {:found, 0}

    row1 = "#.##..##."
    row2 = "...#..##."
    assert DayThirteen.find_smudge_index_in_row(row1, row2) == :not_found

    row1 = "#.##..##."
    assert DayThirteen.find_smudge_index_in_row(row1, row1) == :equal
  end

  # @tag skip: true
  test "Find Smudge and replace input" do
    input = """
    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

    assert DayThirteen.find_smudge_and_replace(input) |> IO.inspect(label: "smudge and replace")
  end

  @tag skip: true
  test "DayThirteen - test part two" do
  	assert File.read!("./inputs/day_thirteen/test_input.txt")
  	   |> DayThirteen.part_two() == 400
  end

  # test "DayThirteen - challenge part two" do
  # 	assert File.read!("./inputs/day_thirteen/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayThirteen.part_two()
  # 	   |> IO.inspect(label: "day_thirteen - challenge two")
  # end
end
