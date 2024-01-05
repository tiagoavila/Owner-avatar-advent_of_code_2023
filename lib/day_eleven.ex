defmodule DayEleven do
	def part_one(input) do
		374
	end

	def expand_gallaxy_map(input) do
		input
		|> Enum.flat_map(&(if String.contains?(&1, "#"), do: [&1, &1], else: [&1]))
	end

	def part_two(input) do

	end
end
