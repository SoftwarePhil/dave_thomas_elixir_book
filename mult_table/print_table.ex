defmodule PrintTable  do

  @moduledoc """
  ##the largest number will be the max colum size
  |     1|     2|     3|     4|
  |   100|   200|200000|     3|
  """
#so many reduces / maps wonder how to make more efficent

  def print(list) do
    _values = with list = Enum.map(list, fn({_num, list}) -> list end),
         longest = Enum.map(list, fn(x) -> find_longest_number(x) end) |> Enum.max,
         rows = Enum.map(list, fn(a_list) -> make_row(a_list, longest) end)
    do
      _table = Enum.reduce(rows, "", fn(x, acc) -> acc <> x<> "\n" end)
      |>IO.puts
    end
  end

  def find_longest_number(list) do
    Enum.map(list, fn(x) -> when_larger(x, 0) end)
    |>Enum.max
  end

  defp when_larger(x, acc) when acc < x do
    Integer.digits(x)
    |> Enum.count
  end

  defp when_larger(_, acc) do
    acc
  end

  def make_row(list, largest_space) do
    Enum.reduce(list, "", fn(x, acc) ->
                            how_many? = largest_space - (Integer.digits(x) |> Enum.count)
                            space = make_spaces(how_many?)
                            acc <> "|" <> space <> Integer.to_string(x) end) <> "|"
  end

  defp make_spaces(num) do
    0..num
    |>Enum.to_list
    |>Enum.reduce("", fn(_x, acc) -> acc <> " " end)
  end

end
