defmodule PentoWeb.WrongLive do
Pento.Account
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, page_title: "Guess Game")

    {:ok,
      assign(socket,
      score: 0,
      message: "Make a guess:",
      target: Enum.random(1..10)
    )}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
      <h1>Welcome back <%= assigns.current_user.username %>, your score is: <%= @score %></h1>

      <h2>
        <%= @message %>

        <br>
        <%= assigns.session_id %> - <%= @current_user.username %>
      </h2>

      <br>

      <h3>Target: <%= @target %></h3>

      <br>

      <%= for n <- 1..10 do %>
        <.link
          class="inline-block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          href="#"
          phx-click="guess"
          phx-value-number={n}
        >
          <button><%= n %></button>
        </.link>
      <% end %>

      <h1>
        <.link
          class="inline-block bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          href="#"
          phx-click="restart"
        >
          <button>RESTART</button>
        </.link>
      </h1>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    guess = String.to_integer(guess)

    message =
      if socket.assigns.target == guess do
        "You won the game, #{socket.assigns.current_user.email}!!!"
      else
        "Your guess was #{guess}. Wrong. Guess again!"
      end

    score =
      if socket.assigns.target == guess do
        socket.assigns.score + 1
      else
        socket.assigns.score - 1
      end

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def handle_event("restart", _params, socket) do
    target = Enum.random(1..10)

    {
      :noreply,
      assign(
        socket,
        message: nil,
        target: target
      )
    }
  end
end
