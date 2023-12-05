defmodule DayThree.Accumulator do
  defstruct numbers: [],
            valid_symbols: %{},
            previous: "",
            is_previous_a_valid_symbol: false,
            is_previous_a_number: false,
            add_number_as_valid: false
end
