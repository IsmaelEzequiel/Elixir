defmodule TwitchChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TwitchChatWeb.Telemetry,
      TwitchChat.Repo,
      {DNSCluster, query: Application.get_env(:twitch_chat, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TwitchChat.PubSub},
      # Start a worker by calling: TwitchChat.Worker.start_link(arg)
      # {TwitchChat.Worker, arg},
      # Start to serve requests, typically the last entry
      TwitchChatWeb.Endpoint,
      {Registry, keys: :unique, name: TwitchChat.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: TwitchChat.BotSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TwitchChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TwitchChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
