defmodule SpawnBasic do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, { :ok, "Hello, #{msg}" })
        greet()
      after 2000 ->
        IO.puts("lls")
    end

  end
end

# Client
pid = spawn(SpawnBasic, :greet, [])

send(pid, { self(), "World!" })
receive do
  {:ok, msg} ->
    IO.puts(msg)
end

send(pid, { self(), "Lídia!" })
receive do
  {:ok, msg} ->
    IO.puts(msg)
  after 500 ->
    IO.puts("The greeter has gona =(")
end
