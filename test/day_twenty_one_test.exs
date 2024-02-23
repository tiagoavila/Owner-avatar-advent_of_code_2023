defmodule DayTwentyOneTest do
  use ExUnit.Case

  test "DayTwentyOne - test part one" do
    assert File.read!("./inputs/day_twenty_one/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwentyOne.part_one(6) == 16
  end

  @tag skip: true
  test "DayTwentyOne - challenge part one" do
  assert File.read!("./inputs/day_twenty_one/challenge_input.txt")
         |> String.split("\r\n", trim: true)
         |> DayTwentyOne.part_one()
         |> IO.inspect(label: "DayTwentyOne - challenge one")
  end

  # test "DayTwentyOne - test part two" do
  # 	assert File.read!("./inputs/day_twenty_one/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTwentyOne.part_two() == 0
  # end

  # test "DayTwentyOne - challenge part two" do
  # 	assert File.read!("./inputs/day_twenty_one/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTwentyOne.part_two()
  # 	   |> IO.inspect(label: "day_twenty_one - challenge two")
  # end
end
