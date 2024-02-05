defmodule DaySeventeenTest do
  use ExUnit.Case

  @tag skip: true
  test "DaySeventeen - test part one" do
    assert File.read!("./inputs/day_seventeen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeventeen.part_one() == 102
  end

  @tag skip: true
  test "DaySeventeen - test code from Elixir Forum" do
    assert File.read!("./inputs/day_seventeen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> Helper.parse_list_of_lists_to_map(&String.to_integer(&1))
           |> AoC2023.Day17.part1() == 102
  end

  @tag skip: true
  test "DaySeventeen - test smallest input" do
    assert """
           241347
           126547
           315527
           311958
           432269
           143122
           """
           |> String.split("\r\n", trim: true)
           |> DaySeventeen.part_one() == 15
  end

  @tag skip: true
  test "DaySeventeen - challenge part one" do
    assert File.read!("./inputs/day_seventeen/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeventeen.part_one() == 674
  end

  @tag skip: true
  test "DaySeventeen - test part two" do
  	assert File.read!("./inputs/day_seventeen/test_input.txt")
  	   |> String.split("\r\n", trim: true)
  	   |> DaySeventeen.part_two() == 94
  end

  @tag skip: true
  test "DaySeventeen - challenge part two" do
  	assert File.read!("./inputs/day_seventeen/challenge_input.txt")
  	   |> String.split("\r\n", trim: true)
  	   |> DaySeventeen.part_two()
  	   |> IO.inspect(label: "day_seventeen - challenge two")
  end
end
