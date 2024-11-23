defmodule HelloSocketsWeb.AuthSocket do
  use Phoenix.Socket
  require Logger

  channel "ping:*", HelloSocketsWeb.PingChannel
  channel "user:*", HelloSocketsWeb.AuthChannel

  @secret_key_base Application.compile_env(:hello_sockets, HelloSocketsWeb.Endpoint)[:secret_key_base]

  @one_day 86400

  @impl true
  def connect(%{"token" => token}, socket) do
    case verify(socket, token) do
      {:ok, user_id} ->
        socket = assign(socket, :user_id, user_id)
        {:ok, socket}

      {:error, reason} ->
        Logger.error("#{__MODULE__} connect error #{inspect(reason)}")
        :error
    end
  end

  def connect(_, _socket) do
    Logger.error("#{__MODULE__} connect error missing params")
    :error
  end

  defp verify(socket, token) do
    Phoenix.Token.verify(socket, @secret_key_base, token, max_age: @one_day)
  end

  @impl true
  def id(socket), do: "user_socket:#{socket.assigns.user_id}"
end
