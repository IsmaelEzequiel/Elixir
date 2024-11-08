require Integer

IO.puts("-> Cycle --------------------------------")

cycle =
  Stream.cycle(~W{ black white })
    |> Enum.zip(1..10)
    |> Enum.map(fn { color, value } -> [color, value] end)

IO.inspect(cycle)

IO.puts("\n\n-> Iterate --------------------------------")

iterate =
  Stream.iterate(1, &(&1 * 2))
    |> Enum.take(10)

IO.inspect(iterate)

IO.puts("\n\n-> Repeatedly --------------------------------")

repeat =
  Stream.repeatedly(fn () -> trunc(:rand.uniform() * 100) end)
    |> Enum.take(10)
    |> Enum.into(MapSet.new)
    |> Enum.to_list

IO.inspect(repeat)

IO.puts("\n\n-> Comprehension --------------------------------")

IO.inspect for x <- [1,2], y <- [3,4], do: y * x
IO.inspect for x <- 1..5, x < 4, do: %{ x: x,  y: x * x }
IO.inspect for x <- ~W{ cat dog }, into: %{}, do: { x, String.upcase(x) }
IO.inspect for x <- ~W{ oi lindo meu amor }, into: MapSet.new, do: { x, String.upcase(x) }

IO.inspect [1,2]
  |> Enum.zip([3,4])
  |> Enum.map(fn { x, y } -> y * x end)

IO.puts("\n\n-> Get_in --------------------------------")

# IO.inspect get_and_update_in(cast, [Access.all(), :actor, :last], fn (val) -> {val, String.upcase(val)} end)
map = for x <- 1..4, y <- 4..5, do: %{ x: y, y: y }


IO.inspect map |> Enum.to_list |> get_in([Access.all(), :x])
