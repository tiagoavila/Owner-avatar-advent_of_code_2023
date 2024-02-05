defmodule DayEighteenTest do
	use ExUnit.Case

	test "DayEighteen - test part one" do
    assert File.read!("./inputs/day_eighteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEighteen.part_one() == 62
	end

	# test "DayEighteen - challenge part one" do
    # assert File.read!("./inputs/day_eighteen/challenge_input.txt")
    #        |> String.split("\r\n", trim: true)
    #        |> DayEighteen.part_one()
    #        |> IO.inspect(label: "DayEighteen - challenge one")
	# end

	# test "DayEighteen - test part two" do
	# 	assert File.read!("./inputs/day_eighteen/test_input.txt")
	# 	   |> String.split("\r\n", trim: true)
	# 	   |> DayEighteen.part_two() == 0
	# end

	#test "DayEighteen - challenge part two" do
	#	assert File.read!("./inputs/day_eighteen/challenge_input.txt")
	#	   |> String.split("\r\n", trim: true)
	#	   |> DayEighteen.part_two()
	#	   |> IO.inspect(label: "day_eighteen - challenge two")
	#end
end
