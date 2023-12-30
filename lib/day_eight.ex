defmodule DayEight do
	def part_one(input) do
		[lr_instructions | nodes] = input

		nodes_map = nodes
		|> parse_input_to_nodes_map()

		lr_instructions
		|> String.graphemes()
		|> Stream.cycle()
		|> Enum.reduce_while({"AAA", 0, nodes_map}, &move_to_node/2)
	end

	defp move_to_node(_, {"ZZZ", steps, _}), do: {:halt, steps}

	defp move_to_node("L", {node, steps, nodes_map}) do
		{node_to_move, _} = Map.get(nodes_map, node)
		{:cont, {node_to_move, steps + 1, nodes_map}}
	end

	defp move_to_node("R", {node, steps, nodes_map}) do
		{_, node_to_move} = Map.get(nodes_map, node)
		{:cont, {node_to_move, steps + 1, nodes_map}}
	end

	defp parse_input_to_nodes_map(input) do
		input
		|> Map.new(fn <<key::binary-size(3), " = (", left::binary-size(3), ", ", right::binary-size(3), _::binary>> ->
			{key, {left, right}}
		end)
	end

	def part_two(input) do

	end
end
