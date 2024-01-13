defmodule DayThreeTest do
  use ExUnit.Case

  @tag skip: true
  test "Day 03 - test part one" do
    assert File.read!("./inputs/day_three/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_one() == 4361
  end

  @tag skip: true
  test "Day 03 - challenge part one" do
    assert File.read!("./inputs/day_three/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_one()
           |> IO.inspect(label: "Day 02 - challenge one")
  end

  @tag skip: true
  test "Day 03 - test part two" do
    assert File.read!("./inputs/day_three/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_two() == 467_835
  end

  @tag skip: true
  test "Day 03 - challenge part two" do
    assert File.read!("./inputs/day_three/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_two()
           |> IO.inspect(label: "Day 02 - challenge two")
  end
end
