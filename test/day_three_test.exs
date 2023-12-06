defmodule DayThreeTest do
  use ExUnit.Case

  test "Day 03 - test part one" do
    assert File.read!("./inputs/day_three/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_one() == 4361
  end

  test "Day 03 - challenge part one" do
    assert File.read!("./inputs/day_three/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_one()
           |> IO.inspect(label: "Day 02 - challenge one")
  end

  test "Day 03 - test part two" do
    assert File.read!("./inputs/day_three/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_two() == 467_835
  end
end
