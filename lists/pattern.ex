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

# people = [
#   %{ name: "Grumpy", height: 1.24},
#   %{ name: "Dave", height: 1.88},
#   %{ name: "Dopey", height: 1.32},
#   %{ name: "Shaquille", height: 2.16 },
#   %{ name: "Sneezy", height: 1.28 }
# ]

# IO.inspect(for person = %{height: height} <- people, height > 1.5, do: person)

# others = %{name: "ismael", surname: "ezequiel", likes: 49}

# pa = for key <- [:name, :likes] do
#   %{^key => value} = others
#   value
# end

# IO.inspect(pa)

IO.puts "-----------------------------------"

# IO.puts File.stream!("words") |> Enum.max_by(&String.length/1)

# start = Time.utc_now()

# list = Enum.map(1..10_000_000, &(&1)) |> Enum.filter(&(&1 < 10))

# IO.inspect list

# finish = Time.diff(Time.utc_now(), start, :millisecond)

# IO.inspect "#{finish}ms"

# start_s = Time.utc_now()

# list = Stream.map(1..10_000_000, &(&1)) |> Enum.filter(&(&1 < 10))

# IO.inspect list

# finish_s = Time.diff(Time.utc_now(), start_s, :millisecond)

# IO.inspect "#{finish_s}ms"

list = Stream.cycle(~W{ green white })
  |> Stream.zip(1..10)
  |> Enum.map(fn { class, value } ->
    "<tr class=\"#{class}\"><td>#{value}</td></tr>"
  end)

IO.inspect list

IO.puts "-----------------------------------"

repeat =
  Stream.repeatedly(&:random.uniform/0)
    |> Enum.take(5)
    # |> Enum.map(& trunc(&1 * 100))

IO.inspect repeat

IO.puts "-----------------------------------"

iterate =
  Stream.iterate(1, &(&1+&1)) |> Enum.take(10)

IO.inspect(iterate)
