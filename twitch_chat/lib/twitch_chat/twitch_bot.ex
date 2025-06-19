defmodule TwitchChat.TwitchBot do
  use GenServer

  def start_link(channel) do
    GenServer.start_link(__MODULE__, channel, name: via_tuple(channel))
  end

  def via_tuple(channel) do
    {:via, Registry, {TwitchChat.Registry, "bot:#{channel}"}}
  end

  def init(channel) do
    case connect(channel) do
      {:ok, socket} ->
        IO.puts("✅ Conectado")
        {:ok, %{socket: socket, channel: channel}}

      {:error, _reason} ->
        IO.puts("❌ Falha inicial na conexão. Tentando novamente em 5s...")
        :timer.send_after(5000, :reconnect)
        {:ok, %{socket: nil, channel: channel}}
    end
  end

  defp connect(channel) do
    host = ~c"irc.chat.twitch.tv"
    port = 6667

    case :gen_tcp.connect(host, port, [:binary, active: true, packet: :line]) do
      {:ok, socket} ->
        # Login como justinfan (anônimo)
        :gen_tcp.send(socket, "PASS oauth:ignored\r\n")
        :gen_tcp.send(socket, "NICK justinfan123\r\n")
        :gen_tcp.send(socket, "JOIN ##{channel}\r\n")
        {:ok, socket}

      error ->
        error
    end
  end

  def handle_info({:tcp, socket, msg}, state) do
    cond do
      String.starts_with?(msg, "PING") ->
        IO.puts("✅ PONG")
        :gen_tcp.send(socket, "PONG :tmi.twitch.tv\r\n")
        {:noreply, state}

      true ->
        case parse_privmsg(msg) do
          {:ok, %{user: user, message: message}} ->
            Phoenix.PubSub.broadcast(TwitchChat.PubSub, "chat:#{state.channel}", {:new_msg, user, message})

          :error ->
            IO.inspect("Mensagem ignorada #{msg}")
            {:noreply, state}
        end
    end

    {:noreply, state}
  end

  def handle_info({:tcp_closed, _}, state) do
    IO.puts("🔌 Conexão encerrada. Tentando reconectar em 5s...")
    :timer.send_after(5000, :reconnect)
    {:noreply, %{state | socket: nil}}
  end

  def handle_info(:reconnect, state) do
    case connect(state.channel) do
      {:ok, socket} ->
        IO.puts("🔁 Reconectado!")
        {:noreply, %{state | socket: socket}}

      {:error, _} ->
        IO.puts("❌ Falha ao reconectar. Tentando novamente em 5s...")
        :timer.send_after(5000, :reconnect)
        {:noreply, %{state | socket: nil}}
    end
  end

  def send_raw(socket, data), do: :gen_tcp.send(socket, "#{data}\r\n")

  def parse_privmsg(msg) do
    regex = ~r/^:(?<user>[^\s!]+)![^\s]+ PRIVMSG #[^\s]+ :(?<message>.*)\r?$/
    case Regex.named_captures(regex, msg) do
      %{"user" => user, "message" => message} ->
        {:ok, %{ user: user, message: message }}
      _ ->
        :error
    end
  end
end
