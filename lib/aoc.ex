defmodule Aoc do
  def get_input(day) do
    session = Application.get_env(:advent_of_code_2023, :aoc_session)

    Req.get!(
      "https://adventofcode.com/2023/day/#{day}/input",
      headers: [{"Cookie", ~s"session=#{session}"}]
    ).body
  end
end
