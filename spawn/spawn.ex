defmodule Spawn do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "hello #{msg}"}
    end
  end
end


#client
pid = spawn(Spawn, :greet, [])
send pid, {self, "world"}

receive do
  {:ok, message} -> IO.puts message
end
