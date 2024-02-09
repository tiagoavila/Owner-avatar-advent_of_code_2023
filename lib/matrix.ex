defmodule Matrix do
  def transpose(m) do
    attach_row(m, [])
    |> Enum.map(&Enum.reverse/1)
  end

  # handle ending case first
  def attach_row([], result) do
    result
  end

  def attach_row([first_row | other_rows], result) do
    new_result = make_column(first_row, result)
    attach_row(other_rows, new_result)
  end

  # my job here is done
  def make_column([], result) do
    result
  end

  def make_column([first_item | other_items], []) do
    [[first_item] | make_column(other_items, [])]
  end

  def make_column([first_item | other_items], [first_row | other_rows]) do
    [[first_item | first_row] | make_column(other_items, other_rows)]
  end
end
