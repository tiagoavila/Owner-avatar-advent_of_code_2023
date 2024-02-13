defmodule MidouestDay19Part2 do
  def part2(input) do
    {workflows, _part_ratings} =
      input
      |> parse()

    acceptance(workflows)
    |> Enum.map(fn rating ->
      rating
      |> Map.values()
      |> Enum.map(&Enum.count/1)
      |> Enum.product()
    end)
    |> Enum.sum()
  end

  def acceptance(workflows), do: acceptance("in", workflows) |> Enum.map(&flatten/1)

  def acceptance("R", _), do: false
  def acceptance("A", _), do: true
  def acceptance(<<name::binary>>, workflows), do: acceptance(workflows[name], workflows)
  def acceptance([<<name::binary>>], workflows), do: acceptance(name, workflows)

  def acceptance([{category, op, threshold, output} | rest], workflows) do
    left =
      output
      |> acceptance(workflows)
      |> prepend({category, op, threshold})

    right_op = if op === "<", do: ">=", else: "<="

    right =
      rest
      |> acceptance(workflows)
      |> prepend({category, right_op, threshold})

    left ++ right
  end

  def prepend(false, _), do: []
  def prepend(true, rule), do: [[rule]]
  def prepend(branches, rule), do: Enum.map(branches, &[rule | &1])

  @input "xmas"
         |> String.graphemes()
         |> Enum.map(&{&1, 1..4000})
         |> Map.new()

  def flatten(branch), do: flatten(branch, @input)
  def flatten([], acc), do: acc

  def flatten([{category, op, threshold} | branch], acc) do
    lo..hi = acc[category]

    range =
      case op do
        ">" -> max(threshold + 1, lo)..hi
        ">=" -> max(threshold, lo)..hi
        "<" -> lo..min(threshold - 1, hi)
        "<=" -> lo..min(threshold, hi)
      end

    acc = %{acc | category => range}
    flatten(branch, acc)
  end

  def parse(input) do
    [workflows, ratings] = String.split(input, "\r\n\r\n")

    workflows =
      for line <- String.split(workflows, "\r\n", trim: true), into: %{} do
        [name, rules] = String.split(line, ["{", "}"], trim: true)

        rules =
          for rule <- String.split(rules, ",") do
            case Regex.run(~r/(?:(\w)([<>])(\d+):)?(\w+)/, rule, capture: :all_but_first) do
              ["", "", "", output] ->
                output

              [category, op, threshold, output] ->
                threshold = String.to_integer(threshold)
                {category, op, threshold, output}
            end
          end

        {name, rules}
      end

    ratings =
      for line <- String.split(ratings, "\r\n", trim: true) do
        for field <- String.split(line, ["{", "}", ","], trim: true), into: %{} do
          [key, value] = String.split(field, "=")
          {key, String.to_integer(value)}
        end
      end

    {workflows, ratings}
  end
end
