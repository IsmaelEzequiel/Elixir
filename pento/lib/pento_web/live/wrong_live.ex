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
