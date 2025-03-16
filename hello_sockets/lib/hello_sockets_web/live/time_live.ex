defmodule HelloSocketsWeb.TimeLive do
  use HelloSocketsWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, time: time(), message: "default message")}
  end

  def render(assigns) do
    ~H"""
      <%= @message %>
      It's <%= @time %>

      <h1>
        <.link href="/guess">GO TO GUESS GAME</.link>
      </h1>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string()
  end
end
