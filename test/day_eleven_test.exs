defmodule DayElevenTest do
	use ExUnit.Case

	test "DayEleven - test part one" do
    assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_one() == 374
	end

	test "Expand Gallaxy Map" do
		assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
					 |> DayEleven.expand_gallaxy_map()
					 |> Enum.join() == "....#.................#...#..............................................#.....#.......................#...................................#...#....#......."

	end

	# test "DayEleven - challenge part one" do
    # assert File.read!("./inputs/day_eleven/challenge_input.txt")
    #        |> String.split("\r\n", trim: true)
    #        |> DayEleven.part_one()
    #        |> IO.inspect(label: "DayEleven - challenge one")
	# end

	# test "DayEleven - test part two" do
	# 	assert File.read!("./inputs/day_eleven/test_input.txt")
	# 	   |> String.split("\r\n", trim: true)
	# 	   |> DayEleven.part_two() == 0
	# end

	#test "DayEleven - challenge part two" do
	#	assert File.read!("./inputs/day_eleven/challenge_input.txt")
	#	   |> String.split("\r\n", trim: true)
	#	   |> DayEleven.part_two()
	#	   |> IO.inspect(label: "day_eleven - challenge two")
	#end
end
