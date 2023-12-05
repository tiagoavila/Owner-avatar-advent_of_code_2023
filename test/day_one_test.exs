defmodule DayOneTest do
  use ExUnit.Case

  test "Day 01 - test part one" do
    assert File.read!("./inputs/day_one/test_input.txt")
           |> DayOne.get_sum_of_calibration_values() == 142
  end

  test "Day 01 - challenge part one" do
    assert File.read!("./inputs/day_one/challenge_input.txt")
           |> DayOne.get_sum_of_calibration_values()
           |> IO.inspect(label: "Day 01 - challenge one")
  end

  test "Day 01 - test part two" do
    assert File.read!("./inputs/day_one/test_input_part2.txt")
           |> DayOne.get_sum_of_calibration_values_part2() == 281
  end

  test "Day 01 - challenge part two" do
    assert File.read!("./inputs/day_one/challenge_input.txt")
           |> DayOne.get_sum_of_calibration_values_part2() == 54249
  end
end
