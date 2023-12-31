defmodule DayNine do
	def part_one(input) do
	 input
	 |> Enum.reduce(0, &generate_next_value(&1) + &2)
	end

	def generate_next_value(line_input) do
		line_input
		|> String.split(" ", trim: true)
		|> Enum.map(&String.to_integer/1)
		|> then(&extrapolate/1)
	end

	def extrapolate(history_line) do
		differences = generate_differences_sequency(history_line)
		case Enum.all?(differences, &(&1 == 0)) do
			true -> List.last(history_line)
			false -> List.last(history_line) + extrapolate(differences)
		end
	end

	def generate_differences_sequency(history_line) do
		history_line
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.map(fn [a, b] -> b - a end)
	end

	def part_two(input) do

	end
end
