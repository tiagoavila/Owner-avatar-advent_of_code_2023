defmodule DayTenTest do
	use ExUnit.Case

	test "DayTen - test part one" do
    assert File.read!("./inputs/day_ten/test_input.txt")
           |> DayTen.part_one({1, 0}) == 8
	end

	test "Simple sketch to find loop" do
		simple_sketch = """
		-L|F7
		7S-7|
		L|7||
		-L-J|
		L|-JF
		"""

		assert simple_sketch |> DayTen.part_one({1, 0}) == 4
	end

	test "DayTen - challenge part one" do
    assert File.read!("./inputs/day_ten/challenge_input.txt")
           |> DayTen.part_one({1, 0})
           |> IO.inspect(label: "DayTen - challenge one")
	end

	# test "DayTen - test part two" do
	# 	assert File.read!("./inputs/day_ten/test_input.txt")
	# 	   |> String.split("\r\n", trim: true)
	# 	   |> DayTen.part_two() == 0
	# end

	#test "DayTen - challenge part two" do
	#	assert File.read!("./inputs/day_ten/challenge_input.txt")
	#	   |> String.split("\r\n", trim: true)
	#	   |> DayTen.part_two()
	#	   |> IO.inspect(label: "day_ten - challenge two")
	#end
end
