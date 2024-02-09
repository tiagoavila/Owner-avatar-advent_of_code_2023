defmodule DayThirteen do
  import Matrix, only: [transpose: 1]

  def part_one(input) do
    input
    |> String.split("\r\n\r\n", trim: true)
    |> Enum.map(&find_reflection_lines/1)
    |> Enum.reduce(0, &summarize/2)
  end

  def part_two(input) do
    400
  end

  defp summarize({:horizontal, row}, acc) do
    row * 100 + acc
  end

  defp summarize({:vertical, col}, acc) do
    col + acc
  end

  def find_reflection_lines(pattern) do
    horizontal_reflection =
      pattern
      |> find_reflection()

    case horizontal_reflection do
      {row1, _row2} ->
        {:horizontal, row1}

      :not_found ->
        vertical_reflection =
          pattern
          |> transpose_pattern()
          |> find_reflection()

        case vertical_reflection do
          {col1, _col2} -> {:vertical, col1}
          :not_found -> {}
        end
    end
  end

  def transpose_pattern(pattern) do
    pattern
    |> String.split("\r\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> transpose()
    |> Enum.map_join("\r\n", &Enum.join/1)
  end

  def find_reflection(input) do
    rows_list =
      input
      |> String.split("\r\n", trim: true)
      |> Enum.with_index(1)

    rows_list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.filter(fn [{row_one, index_one}, {row_two, _}] ->
      row_one == row_two && is_reflection_pattern_valid?(rows_list, index_one)
    end)
    |> then(fn reflection_rows ->
      case reflection_rows do
        [] ->
          :not_found

        _ ->
          [[{_, index_one}, {_, index_two}]] = reflection_rows
          {index_one, index_two}
      end
    end)
  end

  defp is_reflection_pattern_valid?(rows, index_one) do
    {list_one, list_two} = Enum.split_while(rows, fn {_, index} -> index <= index_one end)

    list_one
    |> Enum.sort(fn {_, index_one}, {_, index_two} -> index_one > index_two end)
    |> then(&(&1 |> Enum.zip(list_two)))
    |> Enum.all?(fn {{row_one, _}, {row_two, _}} -> row_one == row_two end)
  end

  def find_smudge_and_replace(pattern) do
    pattern
    |> String.split("\r\n", trim: true)
    |> Enum.with_index()
    |> then(fn rows_list ->
      rows_list
      |> Enum.reduce_while([], fn {row, index}, acc ->
        rows_list
        |> Enum.drop(index + 1)
        |> Enum.reduce_while({}, fn {row2, _}, acc2 ->
          case find_smudge_index_in_row(row, row2) do
            {:found, smudge_index} -> {:halt, {:found, smudge_index}}
            _ -> {:cont, acc2}
          end
        end)
        |> then(fn result ->
          case result do
            {:found, smudge_index} ->
              <<previous::binary-size(smudge_index), char, rest::binary>> = row
              updated_row = previous <> replace_char(char) <> rest
              remaining_rows = Enum.drop(rows_list, index + 1) |> Enum.map(fn {row, _} -> row end)
              {:halt, Enum.reverse([updated_row | acc]) ++ remaining_rows}

            _ ->
              {:cont, [row | acc]}
          end
        end)
      end)
    end)
    |> Enum.join("\r\n")
  end

  defp replace_char(?#), do: "."
  defp replace_char(?.), do: "#"

  def find_smudge_index_in_row(row1, row2) do
    chars_row2 =
      row2
      |> String.graphemes()

    row1
    |> String.graphemes()
    |> then(&(&1 |> Enum.zip(chars_row2) |> Enum.with_index()))
    |> Enum.reduce_while({}, fn {{char1, char2}, index}, acc ->
      cond do
        char1 == char2 -> {:cont, acc}
        char1 != char2 && acc == {} -> {:cont, {:found, index}}
        char1 != char2 && acc != {} -> {:halt, :not_found}
      end
    end)
    |> then(fn result -> if result == {}, do: :equal, else: result end)
  end

  def p2(input) do
    {xs, ys} = input |> grids() |> Enum.map(&calculate_with_smudge/1) |> Enum.unzip()

    combine = fn items ->
      items |> List.flatten() |> Enum.map(fn n -> (1 + n) / 2 end) |> Enum.sum()
    end

    100 * combine.(xs) + combine.(ys)
  end

  def calculate(grid) do
    grid = grid |> Enum.map(fn {x, y} -> {2 * x, 2 * y} end) |> MapSet.new()
    max_x = max_(grid, &get_x/1)
    max_y = max_(grid, &get_y/1)

    {1..max_x//2 |> Enum.filter(fn i -> x_reflect?(grid, i, max_x) end),
     1..max_y//2 |> Enum.filter(fn i -> y_reflect?(grid, i, max_y) end)}
  end

  @spec calculate_with_smudge(any()) :: {list(), list()}
  def calculate_with_smudge(grid) do
    {original_xs, original_ys} = calculate(grid)
    grid_set = grid |> MapSet.new()
    max_x = max_(grid_set, &get_x/1)
    max_y = max_(grid_set, &get_y/1)

    for x <- 0..max_x, y <- 0..max_y do
      calculate(invert(grid_set, {x, y}))
    end
    |> Enum.reject(fn
      {[], []} -> true
      _ -> false
    end)
    |> Enum.reduce(fn {x, y}, {x2, y2} -> {x ++ x2, y ++ y2} end)
    |> then(fn {xs, ys} -> {Enum.uniq(xs) -- original_xs, Enum.uniq(ys) -- original_ys} end)
  end

  def invert(grid, p) do
    if MapSet.member?(grid, p) do
      MapSet.delete(grid, p)
    else
      MapSet.put(grid, p)
    end
  end

  def get_x({x, _}), do: x
  def get_y({_, y}), do: y

  def max_(grid, f), do: Enum.max_by(grid, f) |> then(f)

  def x_reflect?(grid, i, max) do
    grid
    |> Enum.group_by(&get_y/1)
    |> Enum.all?(fn {_, row} ->
      Enum.all?(
        row,
        fn {x, y} ->
          x_r = i + i - x
          x_r > max || x_r < 0 || Enum.member?(grid, {x_r, y})
        end
      )
    end)
  end

  def y_reflect?(grid, i, max) do
    grid
    |> Enum.group_by(&get_x/1)
    |> Enum.all?(fn {_, col} ->
      Enum.all?(
        col,
        fn {x, y} ->
          y_r = i + i - y
          y_r > max || y_r < 0 || Enum.member?(grid, {x, y_r})
        end
      )
    end)
  end

  def grid(input) do
    input
    |> String.split("\r\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, col} -> {{row, col}, char} end)
      |> Enum.filter(fn {_, char} -> char == "#" end)
      |> Enum.map(&elem(&1, 0))
    end)
  end

  def grids(input) do
    input |> String.split("\r\n\r\n") |> Enum.map(&grid/1)
  end
end
