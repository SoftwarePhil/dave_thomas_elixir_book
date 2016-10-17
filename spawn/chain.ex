defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
      fn (_, send_to) ->
        spawn(Chain, :counter, [send_to])
      end
      #the acumulator in the reduce is the last pid spawned, the last pid is what is returned by
      #the function, in the function a new process is being spawned

    send last, 0 # to start the count by sending zero to the last process

    receive do #wait for answer, since the first process in the chain that we created will send a message here!
      final_answer when is_integer(final_answer) ->
        "result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end
