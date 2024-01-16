defmodule DayThirteenTest do
	use ExUnit.Case

	@tag skip: true
	test "DayThirteen - test part one" do
    assert File.read!("./inputs/day_thirteen/test_input.txt")
           |> DayThirteen.part_one() == 405
	end

	test "Find reflection horizontal pattern" do
		input = """
#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#
"""

		assert DayThirteen.find_reflection_rows(input) |> IO.inspect(label: "reflection rows")
	end


	test "Find reflection vertical pattern" do
		input = """
#.##..##.
..#.##.#.
##......#
#.......#
..#.##.#.
..##..##.
#.#.##.#.
"""

		assert DayThirteen.find_reflection_rows(input) |> IO.inspect(label: "reflection rows")
	end

	# test "DayThirteen - challenge part one" do
    # assert File.read!("./inputs/day_thirteen/challenge_input.txt")
    #        |> String.split("\r\n", trim: true)
    #        |> DayThirteen.part_one()
    #        |> IO.inspect(label: "DayThirteen - challenge one")
	# end

	# test "DayThirteen - test part two" do
	# 	assert File.read!("./inputs/day_thirteen/test_input.txt")
	# 	   |> String.split("\r\n", trim: true)
	# 	   |> DayThirteen.part_two() == 0
	# end

	#test "DayThirteen - challenge part two" do
	#	assert File.read!("./inputs/day_thirteen/challenge_input.txt")
	#	   |> String.split("\r\n", trim: true)
	#	   |> DayThirteen.part_two()
	#	   |> IO.inspect(label: "day_thirteen - challenge two")
	#end
end
