defmodule OurMacro do
  def putss(body) do
    quote do
      body
    end
  end
end

# require OurMacro

# OurMacro.unless true, do: "EUUUU"

# import Integer

# a = %{a: 1, b: 2}

# c = with {:ok, number} <- Map.fetch(a, :a),
#   true <- is_even(number) do
#     IO.puts("The number #{div(number, 2)} is divided by 2")
#   else
#     :error -> IO.puts("The number is not in map")
#     _ -> IO.puts("Is odd")
#   end

# IO.inspect(c)

# user = %{first: "ismael", name: "ezequiel"}

# casa = with {:ok, first} <- Map.fetch(user, :first),
#     {:ok, name} <- Map.fetch(user, :name) do {:ok, "User #{first} #{name}"} end

# case casa do
#   {:ok, valor} -> IO.puts(valor)
#   _ -> IO.puts("Porra nenhuma")
# end
