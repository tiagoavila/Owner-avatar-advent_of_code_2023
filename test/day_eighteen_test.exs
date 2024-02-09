defmodule DayEighteenTest do
	use ExUnit.Case

	test "DayEighteen - test part one" do
    assert File.read!("./inputs/day_eighteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEighteen.part_one() == 62
	end

	test "DayEighteen - challenge part one" do
    assert File.read!("./inputs/day_eighteen/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEighteen.part_one()
           |> IO.inspect(label: "DayEighteen - challenge one")
	end

	# @tag skip: true
	test "DayEighteen - test part two" do
		assert File.read!("./inputs/day_eighteen/test_input.txt")
		   |> String.split("\r\n", trim: true)
		   |> DayEighteen.part_two() == 952_408_144_115
	end

	test "DayEighteen - test part two from Elixir Forum" do
		assert File.read!("./inputs/day_eighteen/test_input.txt")
		   |> AoC2023.Day18.part_two() == 952_408_144_115
	end

	test "DayEighteen - challenge part two" do
		assert File.read!("./inputs/day_eighteen/challenge_input.txt")
		   |> String.split("\r\n", trim: true)
		   |> DayEighteen.part_two()
		   |> IO.inspect(label: "day_eighteen - challenge two")
	end
end
