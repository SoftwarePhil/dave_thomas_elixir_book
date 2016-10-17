defmodule Between do

def between(first, last) do
  _between([last], first)
end

defp _between(_current = [h | t], first) when  h > first do
  _between([h-1, h] ++ t, first)
end

defp _between(current, _) do
  current
end

def max_value(list = [h | _t]) do
  _max_value(list, h)
end

defp _max_value(list = [h | t], max) when h > max do
  _max_value(t, h)
end

defp _max_value(list = [h | t], max) when h <= max do
  _max_value(t, max)
end

defp _max_value([], max) do
  max
end

end
