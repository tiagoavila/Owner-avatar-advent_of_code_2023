defmodule DayEightTest do
  use ExUnit.Case

  @tag skip: true
  test "DayEight - test part one" do
    assert File.read!("./inputs/day_eight/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEight.part_one() == 6
  end

  @tag skip: true
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

  @tag skip: true
  test "DayEight - challenge part one" do
    assert File.read!("./inputs/day_eight/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEight.part_one()
           |> IO.inspect(label: "DayEight - challenge one")
  end

  @tag skip: true
  test "DayEight - test part two" do
    assert File.read!("./inputs/day_eight/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEight.part_two() == 6
  end

  @tag skip: true
  test "DayEight - challenge part two" do
    assert File.read!("./inputs/day_eight/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEight.part_two()
           |> IO.inspect(label: "day_eight - challenge two")
  end
end
