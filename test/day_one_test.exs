defmodule DayOneTest do
  use ExUnit.Case

  @tag skip: true
  test "Day 01 - test part one" do
    assert File.read!("./inputs/day_one/test_input.txt")
           |> DayOne.get_sum_of_calibration_values() == 142
  end

  @tag skip: true
  test "Day 01 - challenge part one" do
    assert File.read!("./inputs/day_one/challenge_input.txt")
           |> DayOne.get_sum_of_calibration_values()
           |> IO.inspect(label: "Day 01 - challenge one")
  end

  @tag skip: true
  test "Day 01 - test part two" do
    assert File.read!("./inputs/day_one/test_input_part2.txt")
           |> DayOne.get_sum_of_calibration_values_part2() == 281
  end

  @tag skip: true
  test "Day 01 - challenge part two" do
    assert File.read!("./inputs/day_one/challenge_input.txt")
           |> DayOne.get_sum_of_calibration_values_part2() == 54861
  end
end
