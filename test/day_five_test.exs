defmodule DayFiveTest do
  use ExUnit.Case

  @tag skip: true
  test "DayFive - test part one" do
    assert File.read!("./inputs/day_five/test_input.txt")
           |> DayFive.part_one() == 35
  end

  @tag skip: true
  test "DayFive - test seed-to-soil map" do
    seed_to_soil_map_input = "seed-to-soil map:\r\n50 98 2\r\n52 50 48"
    mappings = %DayFiveMappings{}

    %{seed_to_soil_map: seed_to_soil_map} =
      DayFive.parse_and_update_mappings(seed_to_soil_map_input, mappings)

    assert DayFive.map_source_to_destination_value(98, seed_to_soil_map) == 50
    assert DayFive.map_source_to_destination_value(99, seed_to_soil_map) == 51
    assert DayFive.map_source_to_destination_value(53, seed_to_soil_map) == 55
    assert DayFive.map_source_to_destination_value(51, seed_to_soil_map) == 53
    assert DayFive.map_source_to_destination_value(10, seed_to_soil_map) == 10
    assert DayFive.map_source_to_destination_value(48, seed_to_soil_map) == 48
    assert DayFive.map_source_to_destination_value(0, seed_to_soil_map) == 0
  end

  @tag skip: true
  test "DayFive - test find location for seed" do
    input = File.read!("./inputs/day_five/test_input.txt")

    [_ | maps_input] =
      input
      |> String.split("\r\n\r\n", trim: true)

    mappings_struct = DayFive.create_mappings_struct(maps_input)

    seed = 79
    assert DayFive.find_location_for_seed(seed, mappings_struct) == 82
  end

  @tag skip: true
  test "DayFive - challenge part one" do
    assert File.read!("./inputs/day_five/challenge_input.txt")
           |> DayFive.part_one()
           |> IO.inspect(label: "DayFive - challenge one")
  end

  @tag skip: true
  test "DayFive - test part two" do
    assert File.read!("./inputs/day_five/test_input.txt")
           |> DayFive.part_two() == 46
  end

  @tag skip: true
  test "DayFive - challenge part two" do
    assert File.read!("./inputs/day_five/challenge_input.txt")
           |> DayFive.part_two()
           |> IO.inspect(label: "day_five - challenge two")
  end
end
