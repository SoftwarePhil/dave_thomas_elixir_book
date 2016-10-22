defmodule Sequence.Server do
  use GenServer

  #what the client said, the pid of the client, current state
  def handle_call(:next_number, _from, current_number) do
    #reply tells OTP to reply to the client
    #passing the second value back to the client
    #and the third element is the new state

    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _, _) do
    {:reply, new_number, new_number}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

end
