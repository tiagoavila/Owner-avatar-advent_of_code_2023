defmodule DayFourteenBenchmark do
  use Benchfella

  bench "DayFourteen - test part one" do
    File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part_one()
  end

  bench "DayFourteen - test part one really cool" do
    File.read!("./inputs/day_fourteen/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DayFourteen.part1_really_cool_approach()
  end
end
