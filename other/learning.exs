#looking at lists
defmodule MyList do
  def listP(list, func) do
    proc(list, func)
  end

  defp proc([], _) do
    []
  end

  defp proc([head|tail], func, init_value) do
    [ func.(head) | proc(tail, func) ]
  end

  def list_sum(list, func, init_value) do
    sum(list, func, init_value)
  end

  defp sum([h | t], func, init_value) do
    func.(h, sum(t, func, init_value))
    #h + sum(t)
  end

  # usage # 
  # iex(2)> list_sum([1,2,3], &(&1 + &2), 0)
  # 6

  defp sum([], func, init_value) do
    init_value
  end
end
