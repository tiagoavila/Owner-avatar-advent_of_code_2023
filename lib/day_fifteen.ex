defmodule DayFifteen do
	def part_one(input) do
		input
		|> String.split(",", trim: true)
		|> Enum.reduce(0, fn string, acc ->
			get_hash(string)
			|> Kernel.+(acc)
		end)
	end

	def part_two(input) do

	end

	def get_hash(string) do
		string
		|> String.graphemes()
		|> Enum.reduce(0, fn <<ascii_code::utf8>>, acc ->
			acc
			|> Kernel.+(ascii_code)
			|> Kernel.*(17)
			|> rem(256)
		end)
	end
end
