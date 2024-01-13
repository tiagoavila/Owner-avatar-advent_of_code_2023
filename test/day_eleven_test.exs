defmodule DayElevenTest do
  use ExUnit.Case

  @tag skip: true
  test "DayEleven - test part one" do
    assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_one() == 374
  end

  @tag skip: true
  test "Get Rows and Cols without Gallaxies" do
    assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.get_rows_and_cols_without_gallaxies() == {[7, 3], [2, 5, 8]}
  end

  @tag skip: true
  test "DayEleven - challenge part one" do
    assert File.read!("./inputs/day_eleven/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_one() == 9_522_407
  end

  @tag skip: true
  test "DayEleven - test part two" do
    assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_two(10) == 1_030

    assert File.read!("./inputs/day_eleven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_two(100) == 8_410
  end

  @tag skip: true
  test "DayEleven - challenge part two" do
    assert File.read!("./inputs/day_eleven/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayEleven.part_two(1_000_000)
           |> IO.inspect(label: "day_eleven - challenge two")
  end
end
