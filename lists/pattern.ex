# Lexical

# odd_num = [1,2,3]

# [a, b, _] = odd_num

# IO.puts(a)
# IO.puts(b)

# Int - 1
# Float - 1.1
# Atom - :atom
# Regex - ~r(/casa/, /casa/)
# Ranges - a...b

# PID - self()
# References - make_ref()

# List - []
# Tuple - {}
# Map - %{update | :current => "novo valor"} / Map.put(update, :novo, :valor)
# Binary - <<>>

people = [
  %{ name: "Grumpy", height: 1.24},
  %{ name: "Dave", height: 1.88},
  %{ name: "Dopey", height: 1.32},
  %{ name: "Shaquille", height: 2.16 },
  %{ name: "Sneezy", height: 1.28 }
]

IO.inspect(for person = %{height: height} <- people, height > 1.5, do: person)

others = %{name: "ismael", surname: "ezequiel", likes: 49}

IO.inspect(na)

pa = for key <- [:name, :likes] do
  %{^key => value} = others
  value
end

IO.inspect(pa)
