defmodule HelloSockets.Repo do
  use Ecto.Repo,
    otp_app: :hello_sockets,
    adapter: Ecto.Adapters.Postgres
end
