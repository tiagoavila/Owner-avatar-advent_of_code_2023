defmodule DayFour do
  defstruct cards_count: 0, card_copies: %{}

  def part_one(input) do
    input
    |> Enum.map(fn card_row ->
      [winning_numbers, my_numbers] =
        card_row
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
    input
    |> Enum.with_index()
    |> Enum.reduce(%__MODULE__{}, fn {card_row, index},
                                     %{cards_count: cards_count, card_copies: card_copies} ->
      [winning_numbers, my_numbers] =
        card_row
        |> String.replace(~r/^Card\s\d+:\s/, "")
        |> String.split("|", trim: true)

      map_set_winning_numbers =
        winning_numbers
        |> String.split()
        |> MapSet.new()

      matching_numbers_count =
        my_numbers
        |> String.split()
        |> Enum.count(fn number ->
          MapSet.member?(map_set_winning_numbers, number)
        end)

      card_number = index + 1
      {copies_of_current_card, card_copies} = Map.pop(card_copies, card_number, 0)

      card_copies =
        generate_card_copies(
          matching_numbers_count,
          card_number,
          copies_of_current_card,
          card_copies
        )

      %{
        cards_count: cards_count + 1 + copies_of_current_card,
        card_copies: card_copies
      }
    end)
    |> then(fn %{cards_count: cards_count} -> cards_count end)
  end

  defp generate_card_copies(0, _, _, card_copies), do: card_copies

  defp generate_card_copies(
         matching_numbers_count,
         card_number,
         copies_of_current_card,
         card_copies
       ) do
    copies_of_current_card = if copies_of_current_card == 0, do: 0, else: copies_of_current_card

    (card_number + 1)..(matching_numbers_count + card_number)
    |> Enum.reduce(card_copies, fn copy_card_number, acc ->
      Map.update(
        acc,
        copy_card_number,
        copies_of_current_card + 1,
        &(&1 + copies_of_current_card + 1)
      )
    end)
  end
end
