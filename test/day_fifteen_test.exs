defmodule DayFifteenTest do
  use ExUnit.Case

  @tag skip: true
  test "DayFifteen - test part one" do
    assert "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
           |> DayFifteen.part_one() == 1320
  end

  @tag skip: true
  test "Get Hash for a string" do
    assert "HASH" |> DayFifteen.get_hash() == 52
    assert "rn=1" |> DayFifteen.get_hash() == 30
    assert "cm-" |> DayFifteen.get_hash() == 253
    assert "qp=3" |> DayFifteen.get_hash() == 97
    assert "cm=2" |> DayFifteen.get_hash() == 47
    assert "qp-" |> DayFifteen.get_hash() == 14
    assert "pc=4" |> DayFifteen.get_hash() == 180
    assert "ot=9" |> DayFifteen.get_hash() == 9
    assert "ab=5" |> DayFifteen.get_hash() == 197
    assert "pc-" |> DayFifteen.get_hash() == 48
    assert "pc=6" |> DayFifteen.get_hash() == 214
    assert "ot=7" |> DayFifteen.get_hash() == 231
  end

  @tag skip: true
  test "DayFifteen - challenge part one" do
    assert File.read!("./inputs/day_fifteen/challenge_input.txt")
           |> DayFifteen.part_one()
           |> IO.inspect(label: "DayFifteen - challenge one")
  end

  @tag skip: true
  test "DayFifteen - test part two" do
    assert File.read!("./inputs/day_fifteen/test_input.txt")
           |> DayFifteen.part_two() == 145
  end

  @tag skip: true
  test "DayFifteen - challenge part two" do
    assert File.read!("./inputs/day_fifteen/challenge_input.txt")
           |> DayFifteen.part_two()
           |> IO.inspect(label: "day_fifteen - challenge two")
  end
end
