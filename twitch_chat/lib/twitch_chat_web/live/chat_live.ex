defmodule TwitchChatWeb.ChatLive do
  use TwitchChatWeb, :live_view

  def mount(%{"channel" => channel}, _session, socket) do
    if connected?(socket) do
      TwitchChat.BotManager.ensure_bot_started(channel)
      Phoenix.PubSub.subscribe(TwitchChat.PubSub, "chat:#{channel}")
    end

    {:ok, assign(socket, messages: [], channel: channel)}
  end

  def handle_info({:new_msg, user, message}, socket) do
    {:noreply, update(socket, :messages, fn msgs -> [%{user: user, message: message} | msgs] end)}
  end

  def render(assigns) do
    ~H"""
      <h1>Chat da Twitch - <%= @channel %></h1>
      <div>
        <%= for msg <- @messages do %>
          <p><strong><%= msg.user %></strong>: <%= msg.message %></p>
        <% end %>
      </div>
    """
  end
end
