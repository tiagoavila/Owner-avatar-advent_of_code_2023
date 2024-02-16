defmodule DayTwentyTest do
  use ExUnit.Case

  test "DayTwenty - test part one" do
    assert File.read!("./inputs/day_twenty/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwenty.part_one() == 32000000
  end

  test "Parse input to map" do
    input =
"""
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output
"""

		assert DayTwenty.parse_input_to_map(input) |> IO.inspect()
  end

  # test "DayTwenty - challenge part one" do
  # assert File.read!("./inputs/day_twenty/challenge_input.txt")
  #        |> String.split("\r\n", trim: true)
  #        |> DayTwenty.part_one()
  #        |> IO.inspect(label: "DayTwenty - challenge one")
  # end

  # test "DayTwenty - test part two" do
  # 	assert File.read!("./inputs/day_twenty/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTwenty.part_two() == 0
  # end

  # test "DayTwenty - challenge part two" do
  # 	assert File.read!("./inputs/day_twenty/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTwenty.part_two()
  # 	   |> IO.inspect(label: "day_twenty - challenge two")
  # end
end
