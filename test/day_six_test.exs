defmodule DaySixTest do
  use ExUnit.Case

  @tag skip: true
  test "DaySix - test part one" do
    assert File.read!("./inputs/day_six/test_input.txt")
           |> DaySix.part_one() == 288
  end

  @tag skip: true
  test "Test Calculation of distance based on holding time for race of 7 milliseconds" do
    race_time = 7

    holding_time_expected_distances = [
      {0, 0},
      {1, 6},
      {2, 10},
      {3, 12},
      {4, 12},
      {5, 10},
      {6, 6},
      {7, 0}
    ]

    holding_time_expected_distances
    |> Enum.each(fn {holding_time, expected_distance} ->
      assert DaySix.calculate_distance(holding_time, race_time) == expected_distance
    end)
  end

  @tag skip: true
  test "Test Calculation of distance based on holding time for race of 15 milliseconds" do
    race_time = 15

    holding_time_expected_distances = [
      {0, 0},
      {1, 14},
      {2, 26},
      {3, 36},
      {4, 44},
      {5, 50},
      {6, 54},
      {7, 56},
      {8, 56},
      {9, 54},
      {10, 50},
      {11, 44},
      {12, 36},
      {13, 26},
      {14, 14},
      {15, 0}
    ]

    holding_time_expected_distances
    |> Enum.each(fn {holding_time, expected_distance} ->
      assert DaySix.calculate_distance(holding_time, race_time) == expected_distance
    end)
  end

  @tag skip: true
  test "Test number of Holding Times to beat race of 7 milliseconds" do
    race_time = 7
    distance_to_beat = 9

    assert DaySix.count_holding_time_to_beat_record(race_time, distance_to_beat) == 4
  end

  @tag skip: true
  test "Test number of Holding Times to beat race of 15 milliseconds" do
    race_time = 15
    distance_to_beat = 40

    assert DaySix.count_holding_time_to_beat_record(race_time, distance_to_beat) == 8
  end

  @tag skip: true
  test "Test number of Holding Times to beat race of 30 milliseconds" do
    race_time = 30
    distance_to_beat = 200

    assert DaySix.count_holding_time_to_beat_record(race_time, distance_to_beat) == 9
  end

  @tag skip: true
  test "Test number of Holding Times to beat race of 71530 milliseconds" do
    race_time = 71530
    distance_to_beat = 940_200

    assert DaySix.count_holding_time_to_beat_record(race_time, distance_to_beat) == 71503
  end

  @tag skip: true
  test "DaySix - challenge part one" do
    assert File.read!("./inputs/day_six/challenge_input.txt")
           |> DaySix.part_one()
           |> IO.inspect(label: "DaySix - challenge one")
  end

  @tag skip: true
  test "DaySix - test part two" do
    assert File.read!("./inputs/day_six/test_input.txt")
           |> DaySix.part_two() == 71503
  end

  @tag skip: true
  test "DaySix - challenge part two" do
    assert File.read!("./inputs/day_six/challenge_input.txt")
           |> DaySix.part_two()
           |> IO.inspect(label: "day_six - challenge two")
  end
end
