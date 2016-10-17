defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "hello #{msg}"}
        greet
    end
  end
end

#client
pid = spawn(Spawn2, :greet, [])

send pid, {self, "world"}
  receive do
    {:ok, message} -> IO.puts message
  end

send pid, {self, "another message"}
  receive do
    {:ok, message} -> IO.puts message
  after 500 -> IO.puts "the greeter has left"
end
