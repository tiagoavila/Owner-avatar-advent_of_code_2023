defmodule DayNineteen do
  def part_one(input) do
    [workflows, part_ratings] =
      input
      |> String.split("\r\n\r\n", trim: true)

    workflows_map = parse_workflows_to_map_of_functions(workflows)

    part_ratings
    |> String.split("\r\n", trim: true)
    |> Task.async_stream(fn part_rating ->
      part_rating = parse_part_rating_to_map(part_rating)
      result = process_workflow("in", part_rating, workflows_map)
      {part_rating, result}
    end)
    |> Enum.filter(fn {:ok, {_, result}} -> result == "A" end)
    |> Enum.reduce(0, fn {:ok, {part_rating, _}}, acc ->
      part_rating
      |> Map.values()
      |> Enum.sum()
      |> Kernel.+(acc)
    end)
  end

  def part_two(input) do
    [workflows, _part_ratings] =
      input
      |> String.split("\r\n\r\n", trim: true)

    workflows_map = parse_workflows_to_map(workflows)
    process_workflow_p2("in", %{"x" => {1, 4000}, "m" => {1, 4000}, "a" => {1, 4000}, "s" => {1, 4000}}, workflows_map, [])
  end

  def process_workflow_p2("A", part_rating, _, accepted_ratings), do: [part_rating | accepted_ratings]
  def process_workflow_p2("R", _, _, accepted_ratings), do: accepted_ratings

  def process_workflow_p2(workflow_name, part_rating, workflows_map, accepted_ratings) do
    workflows_map[workflow_name]
    |> Enum.reduce(accepted_ratings, fn workflow, acc ->
      case workflow do
        {cat, comparer, value, next_workflow} ->
          {lo, hi} = part_rating[cat]

          case comparer do
            "<" ->
              new_hi = value - 1

              left_part_rating = Map.replace(part_rating, cat, {lo, new_hi})
              right_part_rating = Map.replace(part_rating, cat, {value, hi})

              process_workflow_p2(next_workflow, left_part_rating, workflows_map, acc)
              ++ process_workflow_p2(next_workflow, right_part_rating, workflows_map, acc)

            ">" ->
              if part_rating[cat] > value do
                process_workflow_p2(next_workflow, part_rating, workflows_map, acc)
              else
                acc
              end
          end
        {next_workflow} -> process_workflow_p2(next_workflow, part_rating, workflows_map, acc)
      end
    end)
  end

  def process_workflow("A", _, _), do: "A"
  def process_workflow("R", _, _), do: "R"

  def process_workflow(workflow_name, part_rating, workflows_map) do
    workflows_map[workflow_name]
    |> Enum.reduce_while("", fn workflow_function, acc ->
      case workflow_function.(part_rating) do
        :cont -> {:cont, acc}
        result -> {:halt, result}
      end
    end)
    |> process_workflow(part_rating, workflows_map)
  end

  def parse_part_rating_to_map(part_rating) do
    part_rating
    |> String.trim_leading("{")
    |> String.trim_trailing("}")
    |> String.split(",", trim: true)
    |> Enum.into(%{}, fn part ->
      [key, value] = String.split(part, "=")
      {key, String.to_integer(value)}
    end)
  end

  def parse_workflows_to_map(workflows, line_breaker \\ "\r\n") do
    workflows
    |> String.split(line_breaker, trim: true)
    |> Enum.reduce(%{}, fn workflow, acc ->
      [workflow_name, rules] = String.split(workflow, "{")

      workflow_tuples =
        rules
        |> String.trim_trailing("}")
        |> String.split(",")
        |> Enum.map(&parse_rule_to_tuple/1)

      Map.put(acc, workflow_name, workflow_tuples)
    end)
  end

  def parse_workflows_to_map_of_functions(workflows, line_breaker \\ "\r\n") do
    workflows
    |> String.split(line_breaker, trim: true)
    |> Enum.reduce(%{}, fn workflow, acc ->
      [workflow_name, rules] = String.split(workflow, "{")

      workflow_functions =
        rules
        |> String.trim_trailing("}")
        |> String.split(",")
        |> Enum.map(&parse_rule_to_function/1)

      Map.put(acc, workflow_name, workflow_functions)
    end)
  end

  def parse_rule_to_function(rule) do
    case String.split(rule, ":") do
      [expression, result] ->
        <<cat::binary-size(1), comparer::binary-size(1), value::binary>> = expression

        fn part_rate ->
          case comparer do
            "<" ->
              if part_rate[cat] < String.to_integer(value) do
                result
              else
                :cont
              end

            ">" ->
              if part_rate[cat] > String.to_integer(value) do
                result
              else
                :cont
              end
          end
        end

      [result] ->
        fn _ -> result end
    end
  end

  def parse_rule_to_tuple(rule) do
    case String.split(rule, ":") do
      [expression, next_workflow] ->
        <<cat::binary-size(1), comparer::binary-size(1), value::binary>> = expression

        {cat, comparer, String.to_integer(value), next_workflow}

      [next_workflow] ->
        {next_workflow}
    end
  end
end
