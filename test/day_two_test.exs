defmodule DayTwoTest do
  use ExUnit.Case

  @tag skip: true
  test "Day 02 - test part one" do
    assert File.read!("./inputs/day_two/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwo.part_one() == 8
  end

  @tag skip: true
  test "Day 02 - challenge part one" do
    assert File.read!("./inputs/day_two/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwo.part_one()
           |> IO.inspect(label: "Day 02 - challenge one")
  end

  @tag skip: true
  test "Day 02 - test part two" do
    assert File.read!("./inputs/day_two/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwo.part_two() == 2286
  end

  @tag skip: true
  test "Day 02 - challenge part two" do
    assert File.read!("./inputs/day_two/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayTwo.part_two()
           |> IO.inspect(label: "Day 02 - challenge two")
  end
end
