list1 = [1,2,3]
list2 = [5 | list1]

IO.puts(list2)
IO.inspect(1..10)

{status, code, _} = {:ok, 404, "saved"}

IO.inspect(status)
IO.inspect(code)

# Enum.__info__(:functions) |> enum.each(fn({function, arity}) ->
#  io.puts("#{function}/#{arity}")
# end)

casa = fn (a, b) -> a + b end
same = &(&1 + &2)

IO.puts(same.(10, 20))

IO.puts(casa.(2,3))

# functions receives function as parameter
sum = &(&1 * 2)
apply = fn (func, value) -> func.(value) end

IO.puts(apply.(sum, 10))

prefix = fn (p) -> &("#{p} #{&1}") end

mrs = prefix.("Mrs")
IO.puts(mrs.("Kel"))

IO.puts(prefix.("Elixir").("Rocks"))


