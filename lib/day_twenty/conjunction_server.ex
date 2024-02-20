defmodule DayTwenty.ConjunctionServer do
  use GenServer

  # Client
  def send_pulse(module_name, pulse, sender_module) do
    GenServer.call(module_name, {:pulse, pulse, sender_module})
  end

  # Server (callbacks)
  @impl true
  def init(data) do
    {:ok, data}
  end

  @impl true
  def handle_call({:pulse, pulse, sender_module}, _from, state) do
    #  {:conjunction, [:output], %{a: :low, b: :low}}

    {:conjunction, destination_modules, module_state} = state
    updated_module_state = Map.replace(module_state, sender_module, pulse)

    # When a pulse is received, the conjunction module first updates its memory for that input.
    # Then, if it remembers high pulses for all inputs, it sends a low pulse;
    # otherwise, it sends a high pulse.

    pulse_to_send =
      Map.values(updated_module_state)
      |> Enum.all?(&(&1 == :high))
      |> then(&(if &1, do: :low, else: :high))

    new_state = {:conjunction, destination_modules, updated_module_state}

    {:reply, {destination_modules, pulse_to_send}, new_state}

  end
end
