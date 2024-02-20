defmodule DayTwenty.FlipFlopServer do
  use GenServer

  # Client
  def send_pulse(module_name, pulse) do
    GenServer.call(module_name, {:pulse, pulse})
  end

  # Server (callbacks)
  @impl true
  def init(data) do
    {:ok, data}
  end

  @impl true
  def handle_call({:pulse, :low}, _from, state) do
    {:flip_flop, destination_modules, module_state} = state

    {new_state, pulse_to_send} =
      case module_state do
        :off ->
          {{:flip_flop, destination_modules, :on}, :high}

        :on ->
          {{:flip_flop, destination_modules, :off}, :low}
      end

    {:reply, {destination_modules, pulse_to_send}, new_state}
  end

  @impl true
  def handle_call({:pulse, :high}, _from, state) do
    {:reply, {}, state}
  end
end
