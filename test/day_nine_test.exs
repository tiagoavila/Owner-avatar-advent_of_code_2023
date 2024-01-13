defmodule DayNineTest do
  use ExUnit.Case

  @tag skip: true
  test "DayNine - test part one" do
    assert File.read!("./inputs/day_nine/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayNine.part_one() == 114
  end

  @tag skip: true
  test "Generate new value" do
    assert DayNine.generate_next_value("0 3 6 9 12 15") == 18
    assert DayNine.generate_next_value("1 3 6 10 15 21") == 28
    assert DayNine.generate_next_value("10 13 16 21 30 45") == 68
  end

  @tag skip: true
  test "Generate differences for a single line" do
    assert DayNine.generate_differences_sequency([0, 3, 6, 9, 12, 15]) == [3, 3, 3, 3, 3]
    assert DayNine.generate_differences_sequency([3, 3, 3, 3, 3]) == [0, 0, 0, 0]
  end

  @tag skip: true
  test "DayNine - challenge part one" do
    assert File.read!("./inputs/day_nine/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayNine.part_one()
           |> IO.inspect(label: "DayNine - challenge one")
  end

  # @tag skip: true
  # test "DayNine - test part two" do
  # 	assert File.read!("./inputs/day_nine/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayNine.part_two() == 5
  # end

  @tag skip: true
  test "Generate previous value" do
    assert DayNine.generate_previous_value("10 13 16 21 30 45") == 5
  end

  @tag skip: true
  test "DayNine - challenge part two" do
    assert File.read!("./inputs/day_nine/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayNine.part_two()
           |> IO.inspect(label: "day_nine - challenge two")
  end
end
