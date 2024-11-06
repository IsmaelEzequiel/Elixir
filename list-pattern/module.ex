#test_num = fn
#    x when x < 0 -> :negative
#    0 -> :zero
#    x when x > 0 -> :positive
#  end

defmodule Num do
  def test_num(x) when x < 0, do: :negative
  def test_num(0), do: :zero
  def test_num(_), do: :positive
end

defmodule Fac do
  def fact(1), do: 1
  def fact(x), do: x * fact(x - 1)
end

defmodule Polim do
  def double(x) when is_number(x), do: 2 * x
  def double(x) when is_binary(x), do: x <> x
end

defmodule TestList do
  def empty?([]), do: true
  def empty?([_|_]), do: false
end

IO.puts(Num.test_num(-10))
IO.puts(Num.test_num(0))
IO.puts(Num.test_num(10))

IO.puts("------")

IO.puts(Fac.fact(1))
IO.puts(Fac.fact(3))

IO.puts("------")

IO.puts(Polim.double(5))
IO.puts(Polim.double("Lidia"))

IO.puts("------")

IO.puts(TestList.empty?([]))
IO.puts(TestList.empty?([1,2,3,4]))
