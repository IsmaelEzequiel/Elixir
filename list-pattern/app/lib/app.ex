defmodule App do
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

  @defaults [name: "PADRAO 1", surname: "PADRAO 2"]
  def get_name(opt \\ []) do
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

  @peoples [
    %{name: "ismael", age: 28},
    %{name: "lidia", age: 25},
    %{name: "Eduarda", age: 26},
    %{name: "Ezequiel", age: 29}
  ]

  def print_names do
    for person = %{ age: age } <- @peoples, age > 25, do: person
  end

  def a do
    @peoples |> Enum.map(& &1[:name])
  end

  def b do
    customer = %Customer{name: "Lidia", company: "none"}
    report = %BugReport{owner: customer, details: "empty", severity: 2}

    report
  end

  def tamanho(valor, segundo) do
    String.length(valor) + String.length(segundo)
  end
end
