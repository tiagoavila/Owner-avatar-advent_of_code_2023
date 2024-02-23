defmodule DayTwentyTest do
  use ExUnit.Case

  @tag skip: true
  test "DayTwenty - test part one" do
    assert File.read!("./inputs/day_twenty/test_input.txt")
           |> DayTwenty.part_one() == 32_000_000
  end

  @tag skip: true
  test "DayTwenty - test part one midouest" do
    assert File.read!("./inputs/day_twenty/test_input.txt")
           |> MidouestDay19Part1.part_one() == 32_000_000
  end

  @tag skip: true
  test "DayTwenty - test part one example 2" do
    input =
      """
      broadcaster -> a
      %a -> inv, con
      &inv -> b
      %b -> con
      &con -> output
      """

    assert input |> DayTwenty.part_one() == 11_687_500
  end

  @tag skip: true
  test "DayTwenty - test part one example 2 midouest" do
    input =
      """
      broadcaster -> a
      %a -> inv, con
      &inv -> b
      %b -> con
      &con -> output
      """

    assert input |> MidouestDay19Part1.part_one() == 11_687_500
  end

  @tag skip: true
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

  @tag skip: true
  test "DayTwenty - challenge part one" do
    assert File.read!("./inputs/day_twenty/challenge_input.txt")
           |> DayTwenty.part_one() == 886_347_020
  end

  @tag skip: true
  test "DayTwenty - challenge part one midouest" do
    assert File.read!("./inputs/day_twenty/challenge_input.txt")
           |> MidouestDay19Part1.part_one() ==
             886_347_020
  end

  # test "DayTwenty - test part two" do
  # 	assert File.read!("./inputs/day_twenty/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTwenty.part_two() == 0
  # end

  @tag skip: true
  test "DayTwenty - challenge part two" do
    assert File.read!("./inputs/day_twenty/challenge_input.txt")
           |> DayTwenty.part_two() == 233_283_622_908_263
  end
end
