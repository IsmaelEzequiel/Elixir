defmodule TwitchChat.Repo do
  use Ecto.Repo,
    otp_app: :twitch_chat,
    adapter: Ecto.Adapters.Postgres
end
