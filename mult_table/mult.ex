#my own code testing ideas
#TODO a real multiplication table, think how to get rid of repeat calcs, don't need so many processes?
defmodule Mult do
import PrintTable

  def make_table(n) do
    pid = spawn(__MODULE__, :get_reply, [[], n])

    with list = Enum.to_list 1..n do
      list
      |>Enum.map(fn x -> spawn(__MODULE__, :each_product, [pid, x, list]) end)
      :ok
    end
  end

  def get_reply(messages, done?) when done? < 1 do
    IO.puts "has run"

    Enum.sort(messages)
    |>print 
  end

  def get_reply(messages, done?) do
    receive do
      {_pid, :done, results} ->
        all_messages = messages ++ [results]
        get_reply(all_messages, done? - 1)
    end
  end


  def each_product(pid, num, list) do
    each_product(pid, num, list, [])
  end

  defp each_product(pid, num, [h|t], results) do
    each_product(pid, num, t, results ++ [num*h])
  #  IO.puts "#{num} * #{h} = #{num*h}"
  end

#returns all answers in a list with {1, [1,2,3,4 .. ect]}
  defp each_product(pid, num, [], results) do
    IO.inspect "#{num} has finished"
    send pid, {self, :done, {num, results}}
    exit(:normal)
  end
end
