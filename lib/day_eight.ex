defmodule DayEight do
  def part_one(input) do
    [instructions_string | nodes] = input

    nodes_map =
      nodes
      |> parse_input_to_nodes_map()

		instructions = instructions_string |> String.graphemes()

    count_steps("AAA", instructions, nodes_map)
  end

	defp count_steps(initial_node, instructions, nodes_map) do
		instructions
    |> Stream.cycle()
    |> Enum.reduce_while({initial_node, 0, nodes_map}, &move_to_node/2)
	end

  defp move_to_node(_, {<<_, _, "Z">>, steps, _}), do: {:halt, steps}

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
    |> Map.new(fn <<key::binary-size(3), " = (", left::binary-size(3), ", ",
                    right::binary-size(3), _::binary>> ->
      {key, {left, right}}
    end)
  end

  def part_two(input) do
    [instructions_string | nodes] = input

    nodes_map =
      nodes
      |> parse_input_to_nodes_map()

		instructions = instructions_string |> String.graphemes()

    nodes_map
    |> Map.keys()
    |> Enum.filter(&String.ends_with?(&1, "A"))
		|> Task.async_stream(&(count_steps(&1, instructions, nodes_map)))
		|> Enum.reduce(1, fn {:ok, steps}, lcm -> div(steps * lcm, Integer.gcd(steps, lcm)) end)
  end
end
