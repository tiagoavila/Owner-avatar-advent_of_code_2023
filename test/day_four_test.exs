defmodule DayFourTest do
  use ExUnit.Case

  test "Day 04 - test part one" do
    assert File.read!("./inputs/day_four/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFour.part_one() == 13
  end

  test "Day 04 - challenge part one" do
    assert File.read!("./inputs/day_four/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFour.part_one()
           |> IO.inspect(label: "Day 04 - challenge one")
  end
end
