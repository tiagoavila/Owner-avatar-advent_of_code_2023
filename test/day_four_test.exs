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

  test "Day 04 - test part two" do
    assert File.read!("./inputs/day_four/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFour.part_two() == 30
  end

  test "Day 04 - challenge part two" do
    assert File.read!("./inputs/day_four/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFour.part_two()
           |> IO.inspect(label: "Day 04 - challenge two")
  end
end
