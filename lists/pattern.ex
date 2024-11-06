# Lexical

odd_num = [1,2,3]

[a, b, _] = odd_num

IO.puts(a)
IO.puts(b)

Int - 1
Float - 1.1
Atom - :atom
Regex - ~r(/casa/, /casa/)
Ranges - a...b

PID - self()
References - make_ref()

List - []
Tuple - {}
Map - %{update | :current => "novo valor"} / Map.put(update, :novo, :valor)
Binary - <<>>
