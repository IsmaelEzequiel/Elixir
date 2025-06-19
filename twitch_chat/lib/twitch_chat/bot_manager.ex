defmodule TwitchChat.BotManager do
  def ensure_bot_started(channel) do
    case Registry.lookup(TwitchChat.Registry, "bot:#{channel}") do
      [] ->
        spec = {TwitchChat.TwitchBot, channel}
        DynamicSupervisor.start_child(TwitchChat.BotSupervisor, spec)
      _ ->
        :ok
    end
  end
end
