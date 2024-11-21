defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def receive_func do
    receive do
      {sender, value} ->
        send(sender, { :ok, "world #{value}" })
    end
  end

  def run do
    # pid = spawn_link(Link1, :receive_func, [])
    # Process.flag(:trap_exit, true)
    # spawn_link(Link1, :sad_function, [])
    # send(pid, { self(), "hellow" })

    res = spawn_monitor(Link1, :sad_function, [])
    IO.puts inspect res

    receive do
      {:ok, msg} ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
      after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Link1.run
