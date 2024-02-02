defmodule DaySeventeenTest do
  use ExUnit.Case

  @tag skip: true
  test "DaySeventeen - test part one" do
    assert File.read!("./inputs/day_seventeen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeventeen.part_one() == 102
  end

  test "DaySeventeen - test smallest input" do
    assert """
241347
126547
315527
318958
422269
143122
    """
    |> String.split("\r\n", trim: true)
    |> DaySeventeen.part_one() == 102
  end

  # test "DaySeventeen - challenge part one" do
  # assert File.read!("./inputs/day_seventeen/challenge_input.txt")
  #        |> String.split("\r\n", trim: true)
  #        |> DaySeventeen.part_one()
  #        |> IO.inspect(label: "DaySeventeen - challenge one")
  # end

  # test "DaySeventeen - test part two" do
  # 	assert File.read!("./inputs/day_seventeen/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DaySeventeen.part_two() == 0
  # end

  # test "DaySeventeen - challenge part two" do
  # 	assert File.read!("./inputs/day_seventeen/challenge_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DaySeventeen.part_two()
  # 	   |> IO.inspect(label: "day_seventeen - challenge two")
  # end
end
