defmodule DayEightTest do
  use ExUnit.Case

  test "DayEight - test part one" do
    assert File.read!("./inputs/day_eight/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEight.part_one() == 6
  end

  test "Simple example to find ZZZ node" do
    input = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    assert input
           |> String.split("\r\n", trim: true)
           |> DayEight.part_one() == 2
  end

  test "DayEight - challenge part one" do
  assert File.read!("./inputs/day_eight/challenge_input.txt")
         |> String.split("\r\n", trim: true)
         |> DayEight.part_one()
         |> IO.inspect(label: "DayEight - challenge one")
  end

  # test "DayEight - test part two" do
  # 	assert File.read!("./inputs/day_eight/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayEight.part_two() == 0
  # end

  # test "DayEight - challenge part two" do
  # 	assert File.read!("./inputs/day_eight/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayEight.part_two()
  # 	   |> IO.inspect(label: "day_eight - challenge two")
  # end
end
