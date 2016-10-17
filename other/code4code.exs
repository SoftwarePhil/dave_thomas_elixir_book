defmodule AnotherCode do
  def encode(list), do: _encode(list, [])

  def _encode([a, a | tail], result) do
      _encode([{a , 2} | tail], result)
  end

  def _encode([{a, n}, a | tail], result) do
      _encode([{a, n+1} | tail], result)
  end

  def _encode([num | tail], result) do
      _encode(tail, [num | result])
  end

  def _encode([], result) do
    Enum.reverse(result)
  end
end

defmodule AnotherCode2 do
  def e(list) do
    list
    |>Enum.reduce([], &_mu/2)
    |>Enum.reverse
  end

  def _mu(next, result) do
    case {next, result} do
      {a, [a | rest]} -> [{a , 2} | rest]
      {a, [{a, n} | rest]} -> [{a , n+1} | rest]
      {a , rest} -> [a | rest]
    end
  end
end

#[1,1,1,2,2,3,3,4,5,6]
#[{1,3},{2,2},{3,2},4,5,6]
