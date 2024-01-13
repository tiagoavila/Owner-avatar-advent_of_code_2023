defmodule DaySeven do
  def part_one(input) do
    input
    |> Enum.map(&(String.split(&1, " ") |> List.to_tuple()))
    |> sort_hands()
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {{_hand, bid}, index}, acc ->
      String.to_integer(bid) * index + acc
    end)
  end

  def sort_hands(hands) do
    hands
    |> Enum.sort(fn {hand_one, _bid_hand_one}, {hand_two, _bid_hand_two} ->
      is_weaker_hand_first?(hand_one, hand_two)
    end)
  end

  @doc """
  	The given function should compare two hands,
  	and return true if the first hand is weaker than the second one.
  """
  @spec is_weaker_hand_first?(binary(), binary()) :: atom()
  def is_weaker_hand_first?(hand_one, hand_two) do
    hand_one_sort_value = get_hand_type(hand_one) |> get_sort_value_for_hand_type()
    hand_two_sort_value = get_hand_type(hand_two) |> get_sort_value_for_hand_type()

    if hand_one_sort_value == hand_two_sort_value do
      # If two hands have the same type, a second ordering rule takes effect.
      # Start by comparing the first card in each hand. If these cards are different,
      # the hand with the stronger first card is considered stronger.
      # If the first card in each hand have the same label, however, then move on to
      # considering the second card in each hand. If they differ, the hand with the higher
      # second card wins; otherwise, continue with the third card in each hand,
      # then the fourth, then the fifth.
      cards_hand_one = hand_one |> String.graphemes()
      cards_hand_two = hand_two |> String.graphemes()

      [cards_hand_one, cards_hand_two]
      |> Enum.zip()
      |> Enum.reduce_while(true, fn {card_one, card_two}, acc ->
        card_one_sort_value = get_sort_value_for_card_type(card_one)
        card_two_sort_value = get_sort_value_for_card_type(card_two)

        if card_one_sort_value == card_two_sort_value do
          {:cont, acc}
        else
          {:halt, card_one_sort_value <= card_two_sort_value}
        end
      end)
    else
      hand_one_sort_value <= hand_two_sort_value
    end
  end

  @spec get_hand_type(binary()) ::
          :five_of_a_kind
          | :four_of_a_kind
          | :full_house
          | :high_card
          | :one_pair
          | :three_of_a_kind
          | :two_pairs
  def get_hand_type(hand) do
    hand
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc -> Map.update(acc, char, 1, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.sort()
    |> Enum.join()
    |> do_get_hand_type()
  end

  defp do_get_hand_type("5"), do: :five_of_a_kind
  defp do_get_hand_type("14"), do: :four_of_a_kind
  defp do_get_hand_type("23"), do: :full_house
  defp do_get_hand_type("113"), do: :three_of_a_kind
  defp do_get_hand_type("122"), do: :two_pairs
  defp do_get_hand_type("1112"), do: :one_pair
  defp do_get_hand_type("11111"), do: :high_card

  defp get_sort_value_for_hand_type(hand_type) do
    case hand_type do
      :five_of_a_kind -> 7
      :four_of_a_kind -> 6
      :full_house -> 5
      :three_of_a_kind -> 4
      :two_pairs -> 3
      :one_pair -> 2
      :high_card -> 1
    end
  end

  defp get_sort_value_for_card_type(card) do
    case card do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      "T" -> 10
      _ -> String.to_integer(card)
    end
  end

  def part_two(input) do
    input
    |> Enum.map(&(String.split(&1, " ") |> List.to_tuple()))
    |> sort_hands_part_two()
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {{_hand, bid}, index}, acc ->
      String.to_integer(bid) * index + acc
    end)
  end

  def sort_hands_part_two(hands) do
    hands
    |> Enum.sort(fn {hand_one, _bid_hand_one}, {hand_two, _bid_hand_two} ->
      is_weaker_hand_first_part_two?(hand_one, hand_two)
    end)
  end

  @doc """
  	The given function should compare two hands,
  	and return true if the first hand is weaker than the second one.
  """
  @spec is_weaker_hand_first_part_two?(binary(), binary()) :: atom()
  def is_weaker_hand_first_part_two?(hand_one, hand_two) do
    hand_one_sort_value = get_hand_type_part_two(hand_one) |> get_sort_value_for_hand_type()
    hand_two_sort_value = get_hand_type_part_two(hand_two) |> get_sort_value_for_hand_type()

    if hand_one_sort_value == hand_two_sort_value do
      cards_hand_one = hand_one |> String.graphemes()
      cards_hand_two = hand_two |> String.graphemes()

      [cards_hand_one, cards_hand_two]
      |> Enum.zip()
      |> Enum.reduce_while(true, fn {card_one, card_two}, acc ->
        card_one_sort_value = get_sort_value_for_card_type_part_two(card_one)
        card_two_sort_value = get_sort_value_for_card_type_part_two(card_two)

        if card_one_sort_value == card_two_sort_value do
          {:cont, acc}
        else
          {:halt, card_one_sort_value <= card_two_sort_value}
        end
      end)
    else
      hand_one_sort_value <= hand_two_sort_value
    end
  end

  @spec get_hand_type_part_two(binary()) ::
          :five_of_a_kind
          | :four_of_a_kind
          | :full_house
          | :high_card
          | :one_pair
          | :three_of_a_kind
          | :two_pairs
  def get_hand_type_part_two("JJJJJ"), do: :five_of_a_kind

  def get_hand_type_part_two(hand) do
    most_repeated_letter = get_most_repeated_letter(hand)

    hand
    |> String.replace("J", most_repeated_letter)
    |> get_hand_type()
  end

  defp get_sort_value_for_card_type_part_two(card) do
    case card do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "T" -> 10
      "J" -> 1
      _ -> String.to_integer(card)
    end
  end

  defp get_most_repeated_letter(str) do
    str
    |> String.replace("J", "")
    |> String.graphemes()
    |> Enum.reduce(%{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
    |> Enum.max_by(&elem(&1, 1))
    |> elem(0)
  end
end
