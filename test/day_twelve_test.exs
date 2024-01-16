defmodule DayTwelveTest do
  use ExUnit.Case

  # @tag skip: true
  test "DayTwelve - test part one" do
    assert File.read!("./inputs/day_twelve/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwelve.part_one() == 21
  end

  # @tag skip: true
  # test "Test generate all combinations" do
  #   assert DayTwelve.generate_all_combinations("???.###")
  #          |> IO.inspect()

  #   assert DayTwelve.generate_all_combinations(".??..??...?##.")
  #          |> IO.inspect()
  # end

  test "Test Validator" do
    assert DayTwelve.validate_combination("#.#.###", [1, 1, 3]) == true
    assert DayTwelve.validate_combination("###.###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##.###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("##..###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("#...###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#..###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#.###", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("....###", [1, 1, 3]) == false

    assert DayTwelve.validate_combination(".#...#....###.", [1, 1, 3]) == true
    assert DayTwelve.validate_combination(".#....#...###.", [1, 1, 3]) == true
    assert DayTwelve.validate_combination("..#..#....###.", [1, 1, 3]) == true
    assert DayTwelve.validate_combination("..#...#...###.", [1, 1, 3]) == true
    assert DayTwelve.validate_combination(".##..##...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##..##....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##..#....###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##..#.....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##...#...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##...#....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##.......###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".##........##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#...##...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#...##....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#...#.....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#....#....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#........###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".#.........##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#..##...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#..##....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#..#.....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#...#....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#.......###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..#........##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".....##...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".....##....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".....#....###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination(".....#.....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("......#...###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("......#....##.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("..........###.", [1, 1, 3]) == false
    assert DayTwelve.validate_combination("...........##.", [1, 1, 3]) == false
  end

  test "Test count valid combinations" do
    assert DayTwelve.count_valid_combinations("???.###", [1, 1, 3]) == 1
    assert DayTwelve.count_valid_combinations(".??..??...?##.", [1, 1, 3]) == 4
  end

  @tag skip: true
  test "DayTwelve - challenge part one" do
  assert File.read!("./inputs/day_twelve/challenge_input.txt")
         |> String.split("\r\n", trim: true)
         |> DayTwelve.part_one() == 7032
        #  |> IO.inspect(label: "DayTwelve - challenge one")
  end

  # @tag skip: true
  test "DayTwelve - test part two" do
  	assert File.read!("./inputs/day_twelve/test_input.txt")
  	   |> String.split("\r\n", trim: true)
  	   |> AoC2023.Day12.part2() == 525152
  end

  # @tag skip: true
  test "DayTwelve - challenge part two" do
  	assert File.read!("./inputs/day_twelve/challenge_input.txt")
  	   |> String.split("\r\n", trim: true)
  	   |> AoC2023.Day12.part2()
  	   |> IO.inspect(label: "day_twelve - challenge two")
  end
end
