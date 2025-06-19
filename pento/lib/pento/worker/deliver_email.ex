defmodule Pento.Worker.DeliverEmail do
  use Oban.Worker, priority: 9, max_attempts: 2
  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{ "email" => email }}) do
    :timer.sleep(1000)

    if :rand.uniform() < 0.3 do
      {:error, "💥 Falha ao processar pedido: " <> inspect(email)}
    else
      IO.puts("✅ Pedido processado com sucesso")
      :ok
    end
  end
end
