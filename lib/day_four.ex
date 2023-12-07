defmodule DayFour do
	def part_one(input) do
		input
		|> Enum.map(fn card_row ->
			[winning_numbers, my_numbers] = card_row
			|> String.replace(~r/^Card\s\d+:\s/, "")
			|> String.split("|", trim: true)

			map_set_winning_numbers =
				winning_numbers
				|> String.split()
				|> MapSet.new()

			my_numbers
			|> String.split()
			|> Enum.reduce(0.5, fn number, acc ->
				if MapSet.member?(map_set_winning_numbers, number) do
					acc * 2
				else
					acc
				end
			end)
			|> trunc()
		end)
		|> Enum.sum()
	end

	def part_two(input) do

	end
end
