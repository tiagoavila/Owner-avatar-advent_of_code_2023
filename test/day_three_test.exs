defmodule DayThreeTest do
  use ExUnit.Case

  test "Day 03 - test part one" do
    assert File.read!("./inputs/day_three/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayThree.part_one() == 4361
  end
end
