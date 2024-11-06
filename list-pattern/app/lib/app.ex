defmodule App do
  @moduledoc """
  Documentation for `App`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> App.hello()
      :world

  """
  def hello do
    :world
  end

  def fac(0), do: 1
  def fac(n) when is_number(n) and n > 1, do: n * fac(n - 1)
  def fac(_), do: :invalid_number

  def len([]), do: 0
  def len([head|tail]), do: head + len(tail)

  def square([]), do: []
  def square([ head | tail ]) do
    [ head * head | square(tail) ]
  end

  def map([], _), do: []
  def map([head|tail], func) do
    [func.(head) | map(tail, func)]
  end

  def reduce([], value, _), do: value
  def reduce([head|tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  def swap([]), do: []
  def swap([a,b|tail]) do
    [b,a | swap(tail)]
  end
  def swap([_]) do
    raise "can't swap odd numbers"
  end

  def filter_for_27([], _), do: []
  def filter_for_27([ head = [_, target, _, _] | tail], target) do
    [head|filter_for_27(tail, target)]
  end
  def filter_for_27([_|tail], target), do: filter_for_27(tail, target)

  @defaults [name: "PADRAO 1", surname: "PADRAO 2"]
  def get_name(n, opt \\ []) do
    opt = Keyword.merge(@defaults, opt)
    IO.puts("Hi #{opt[:name]} #{opt[:surname]}")
    IO.puts("Hi #{Keyword.get(opt, :name)} #{Keyword.get(opt, :surname)}")
    IO.puts("Hi #{Keyword.get(opt, :dontexist, "outro default")} #{opt[:surname]}")
    IO.puts("HI #{Keyword.get_values(opt, :name)} #{Keyword.get_values(opt, :surname)}")
  end

  def for_over_keys do
    keys = %{name: "ismael", age: 20, likes: 30}
    for key <- [:name, :likes] do
      %{^key => name} = keys
      name
    end
  end
end

