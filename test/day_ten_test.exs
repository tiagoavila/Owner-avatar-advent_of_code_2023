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

  @tag skip: true
  test "Simple sketch to find loop and keep track of pipes" do
    simple_sketch = """
    -L|F7
    7S-7|
    L|7||
    -L-J|
    L|-JF
    """

    assert simple_sketch |> DayTen.part_two({1, 0}, "F") == 1
  end

	test "Simple sketch to find loop and keep track of pipes 2" do
    simple_sketch = """
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........
    """

    assert simple_sketch |> DayTen.part_two({1, 0}, "F") == 4
  end

  test "Simple sketch to find loop and keep track of pipes 3" do
    simple_sketch = """
OF----7F7F7F7F-7OOOO
O|F--7||||||||FJOOOO
O||OFJ||||||||L7OOOO
FJL7L7LJLJ||LJIL-7OO
L--JOL7IIILJS7F-7L7O
OOOOF-JIIF7FJ|L7L7L7
OOOOL7IF7||L7|IL7L7|
OOOOO|FJLJ|FJ|F7|OLJ
OOOOFJL-7O||O||||OOO
OOOOL---JOLJOLJLJOOO
    """

    assert simple_sketch |> DayTen.part_two({1, 0}, "F") == 8
  end

  test "Simple sketch to find loop and keep track of pipes 4" do
    simple_sketch = """
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L
    """

    assert simple_sketch |> DayTen.part_two({1, 0}, "F") == 10
  end

  # test "DayTen - test part two" do
  # 	assert File.read!("./inputs/day_ten/test_input.txt")
  # 	   |> String.split("\r\n", trim: true)
  # 	   |> DayTen.part_two() == 0
  # end

  test "DayTen - challenge part two" do
  	assert File.read!("./inputs/day_ten/challenge_input.txt")
  	   |> DayTen.part_two({1, 0}, "F")
  	   |> IO.inspect(label: "day_ten - challenge two")
  end
end
