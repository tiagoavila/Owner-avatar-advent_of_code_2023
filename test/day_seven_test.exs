defmodule DaySevenTest do
  use ExUnit.Case

  @tag skip: true
  test "DaySeven - test part one" do
    assert File.read!("./inputs/day_seven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeven.part_one() == 6440
  end

  @tag skip: true
  test "Get Hand Type" do
    assert DaySeven.get_hand_type("AAAAA") == :five_of_a_kind
    assert DaySeven.get_hand_type("22222") == :five_of_a_kind
    assert DaySeven.get_hand_type("8AAAA") == :four_of_a_kind
    assert DaySeven.get_hand_type("AA8AA") == :four_of_a_kind
    assert DaySeven.get_hand_type("AAAA8") == :four_of_a_kind
    assert DaySeven.get_hand_type("AA88A") == :full_house
    assert DaySeven.get_hand_type("A88AA") == :full_house
    assert DaySeven.get_hand_type("88AAA") == :full_house
    assert DaySeven.get_hand_type("23232") == :full_house
    assert DaySeven.get_hand_type("888AB") == :three_of_a_kind
    assert DaySeven.get_hand_type("888BA") == :three_of_a_kind
    assert DaySeven.get_hand_type("88A8B") == :three_of_a_kind
    assert DaySeven.get_hand_type("88B8A") == :three_of_a_kind
    assert DaySeven.get_hand_type("8A88B") == :three_of_a_kind
    assert DaySeven.get_hand_type("8B88A") == :three_of_a_kind
    assert DaySeven.get_hand_type("3133A") == :three_of_a_kind
    assert DaySeven.get_hand_type("8A8BB") == :two_pairs
    assert DaySeven.get_hand_type("8A8BA") == :two_pairs
    assert DaySeven.get_hand_type("8AABB") == :two_pairs
    assert DaySeven.get_hand_type("8ABAB") == :two_pairs
    assert DaySeven.get_hand_type("8BAAB") == :two_pairs
    assert DaySeven.get_hand_type("8ABBA") == :two_pairs
    assert DaySeven.get_hand_type("A23A4") == :one_pair
    assert DaySeven.get_hand_type("AA234") == :one_pair
    assert DaySeven.get_hand_type("2AA34") == :one_pair
    assert DaySeven.get_hand_type("23456") == :high_card
    assert DaySeven.get_hand_type("2345A") == :high_card
    assert DaySeven.get_hand_type("2345B") == :high_card
    assert DaySeven.get_hand_type("AKQJT") == :high_card
  end

  @tag skip: true
  test "Test sort of hands of different types" do
    one_pair_hand = "32T3K"
    two_pair_hand = "KK677"
    three_of_a_kind_hand = "T55J5"

    assert DaySeven.is_weaker_hand_first?(two_pair_hand, one_pair_hand) == false
    assert DaySeven.is_weaker_hand_first?(one_pair_hand, two_pair_hand) == true

    assert DaySeven.is_weaker_hand_first?(three_of_a_kind_hand, two_pair_hand) == false
    assert DaySeven.is_weaker_hand_first?(two_pair_hand, three_of_a_kind_hand) == true
    assert DaySeven.is_weaker_hand_first?(one_pair_hand, three_of_a_kind_hand) == true
  end

  @tag skip: true
  test "Test sort of hands of same types" do
    two_pair_weaker_hand = "KTJJT"
    two_pair_stronger_hand = "KK677"
    assert DaySeven.is_weaker_hand_first?(two_pair_weaker_hand, two_pair_stronger_hand) == true
    assert DaySeven.is_weaker_hand_first?(two_pair_stronger_hand, two_pair_weaker_hand) == false

    four_of_a_kind_weaker_hand = "2AAAA"
    four_of_a_kind_stronger_hand = "33332"

    assert DaySeven.is_weaker_hand_first?(
             four_of_a_kind_weaker_hand,
             four_of_a_kind_stronger_hand
           ) == true

    assert DaySeven.is_weaker_hand_first?(
             four_of_a_kind_stronger_hand,
             four_of_a_kind_weaker_hand
           ) == false

    full_house_weaker_hand = "77788"
    full_house_stronger_hand = "77888"

    assert DaySeven.is_weaker_hand_first?(full_house_weaker_hand, full_house_stronger_hand) ==
             true

    assert DaySeven.is_weaker_hand_first?(full_house_stronger_hand, full_house_weaker_hand) ==
             false
  end

  @tag skip: true
  test "Test sort of hands" do
    hands = [
      {"32T3K", "765"},
      {"T55J5", "684"},
      {"KK677", "28"},
      {"KTJJT", "220"},
      {"QQQJA", "483"}
    ]

    hands_sorted_from_weakest_to_strongest = [
      {"32T3K", "765"},
      {"KTJJT", "220"},
      {"KK677", "28"},
      {"T55J5", "684"},
      {"QQQJA", "483"}
    ]

    assert DaySeven.sort_hands(hands) == hands_sorted_from_weakest_to_strongest
  end

  @tag skip: true
  test "DaySeven - challenge part one" do
    assert File.read!("./inputs/day_seven/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeven.part_one()
           |> IO.inspect(label: "DaySeven - challenge one")
  end

  @tag skip: true
  test "Test get hand type considering J as Joker" do
    assert DaySeven.get_hand_type_part_two("QJJQQ") == :five_of_a_kind
    assert DaySeven.get_hand_type_part_two("QJJQ2") == :four_of_a_kind
    assert DaySeven.get_hand_type_part_two("T55J5") == :four_of_a_kind
    assert DaySeven.get_hand_type_part_two("KTJJT") == :four_of_a_kind
    assert DaySeven.get_hand_type_part_two("QQQJA") == :four_of_a_kind
  end

  @tag skip: true
  test "Test sort of hands for part two" do
    hands = [
      {"32T3K", "765"},
      {"T55J5", "684"},
      {"KK677", "28"},
      {"KTJJT", "220"},
      {"QQQJA", "483"}
    ]

    hands_sorted_from_weakest_to_strongest = [
      {"32T3K", "765"},
      {"KK677", "28"},
      {"T55J5", "684"},
      {"QQQJA", "483"},
      {"KTJJT", "220"}
    ]

    assert DaySeven.sort_hands_part_two(hands) == hands_sorted_from_weakest_to_strongest
  end

  @tag skip: true
  test "DaySeven - test part two" do
    assert File.read!("./inputs/day_seven/test_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeven.part_two() == 5905
  end

  @tag skip: true
  test "DaySeven - challenge part two" do
    assert File.read!("./inputs/day_seven/challenge_input.txt")
           |> String.split("\r\n", trim: true)
           |> DaySeven.part_two()
           |> IO.inspect(label: "day_seven - challenge two")
  end
end
