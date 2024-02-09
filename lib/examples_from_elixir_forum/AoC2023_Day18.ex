defmodule AoC2023.Day18 do
  @deltas %{
    "0" => {0, 1},
    "1" => {1, 0},
    "2" => {0, -1},
    "3" => {-1, 0}
  }

  def part_two(input) do
    origin = [0, 0]

    {points, _} =
      input
      |> String.split("\r\n", trim: true)
      |> Enum.map_reduce(origin, fn line, [y, x] ->
        [_, <<distance::binary-size(5), direction::binary>>] =
          String.split(line, ~r/[()#]/, trim: true)

        distance = String.to_integer(distance, 16)
        {dy, dx} = @deltas[direction]
        next = [y + distance * dy, x + distance * dx]
        {next, next}
      end)

    segments =
      [origin | points]
      |> Enum.chunk_every(2, 1, :discard)

    area =
      segments
      |> Enum.map(fn [[y1, x1], [y2, x2]] -> y1 * x2 - x1 * y2 end)
      |> Enum.sum()
      |> abs()
      |> div(2)

    perimeter =
      segments
      |> Enum.map(fn [[y1, x1], [y2, x2]] -> abs(y2 - y1) + abs(x2 - x1) end)
      |> Enum.sum()
      |> div(2)

    area + perimeter + 1
  end
end
