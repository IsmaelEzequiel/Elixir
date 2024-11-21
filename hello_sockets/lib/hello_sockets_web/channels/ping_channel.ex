defmodule HelloSocketsWeb.PingChannel do
  use Phoenix.Channel

  def join("ping:lobby", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("ping", _payload, socket) do
    {:reply, {:ok, %{ ping: "pong" }}, socket}
  end

  def handle_in("param_ping", %{"error" => true, "arr" => arr}, socket) do
    {:reply, {:error, %{reason: "You asked for this!", arr: arr}}, socket}
  end

  def handle_in("param_ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end
end
