defmodule DayFifteen do
  def part_one(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.reduce(0, fn string, acc ->
      get_hash(string)
      |> Kernel.+(acc)
    end)
  end

  def part_two(input) do
    boxes = Map.new(0..255, fn box -> {box, []} end)

    input
    |> String.split(",", trim: true)
    |> Enum.reduce(boxes, fn operation, acc ->
      get_operation_type(operation)
      |> process_operation(acc)
    end)
		|> Enum.map(&get_focusing_power/1)
		|> Enum.sum()
  end

  def get_hash(string) do
    string
    |> String.graphemes()
    |> Enum.reduce(0, fn <<ascii_code::utf8>>, acc ->
      acc
      |> Kernel.+(ascii_code)
      |> Kernel.*(17)
      |> rem(256)
    end)
  end

  defp get_operation_type(operation) do
    case Regex.run(~r/=/, operation, return: :index) do
      [{index, _}] ->
        <<lens_label::binary-size(index), "=", focal_length::binary>> = operation
        {:add_lens, lens_label, String.to_integer(focal_length)}

      _ ->
        {:remove_lens, String.replace_suffix(operation, "-", "")}
    end
  end

  defp process_operation({:add_lens, lens_label, focal_length}, boxes) do
    box = get_hash(lens_label)

    case Map.get(boxes, box) do
      [] ->
        %{boxes | box => [{lens_label, focal_length}]}

      box_content ->
        box_content_updated = update_box_content(box_content, lens_label, focal_length)

        %{boxes | box => box_content_updated}
    end
  end

  defp process_operation({:remove_lens, lens_label}, boxes) do
    box = get_hash(lens_label)

    case Map.get(boxes, box) do
      [] ->
        boxes

      box_content ->
        lens_index = Enum.find_index(box_content, fn {label, _} -> label == lens_label end)

        if lens_index != nil,
          do: %{boxes | box => List.delete_at(box_content, lens_index)},
          else: boxes
    end
  end

  defp update_box_content(box_content, lens_label, focal_length) do
    case Enum.find_index(box_content, fn {label, _} -> label == lens_label end) do
      nil ->
        box_content ++ [{lens_label, focal_length}]

      lens_index ->
        List.update_at(box_content, lens_index, fn _ ->
          {lens_label, focal_length}
        end)
    end
  end

	defp get_focusing_power({_, []}), do: 0
	defp get_focusing_power({box, box_content}) do
		box_value = 1 + box

		box_content
		|> Enum.with_index(1)
		|> Enum.reduce(0, fn {{_, focal_length}, slot_number}, acc ->
			lens_power = box_value * slot_number * focal_length
			acc + lens_power
		end)
	end
end
