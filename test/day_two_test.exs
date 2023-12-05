defmodule DayTwoTest do
  use ExUnit.Case

  test "Day 02 - test part one" do
    assert File.read!("./inputs/day_two/test_input.txt")
    |> String.split("\r\n", trim: true)
    |> DayTwo.part_one() == 8
  end

  test "Day 02 - challenge part one" do
    assert File.read!("./inputs/day_two/challenge_input.txt")
    |> String.split("\r\n", trim: true)
    |> DayTwo.part_one()
    |> IO.inspect(label: "Day 02 - challenge one")
  end
end
