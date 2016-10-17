#my own code testing ideas
#TODO a real multiplication table
defmodule Mult do
  def make_table(n) do
    pid = spawn(__MODULE__, :get_reply, [])

    with list = Enum.to_list 1..n do
      list
      |>Enum.map(fn x -> spawn(__MODULE__, :each_product, [pid, x, list]) end)
      :ok
    end
  end

  def get_reply do
    receive do
      {_pid, :done, results} -> print_results results
      get_reply
    end
  end

  def each_product(pid, num, list) do
    each_product(pid, num, list, [])
  end

  defp each_product(pid, num, [h|t], results) do
    each_product(pid, num, t, results ++ [{"#{num} * #{h}", num*h}])
  #  IO.puts "#{num} * #{h} = #{num*h}"
  end

  defp each_product(pid, num, [], results) do
    IO.inspect "#{num} has finished"
    send pid, {self, :done, results}
  end

  def print_results(list) do
    Enum.each(list, fn{str, num} -> IO.inspect "#{str} = #{num}" end)
    #list
  end
end
