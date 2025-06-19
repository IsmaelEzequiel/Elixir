defmodule Pento.WebhookWorker do
  use GenServer
  require Logger

  @interval 1_000_0

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    Logger.info("WebhookWorker iniciado. Enviando requisições a cada #{@interval}ms")
    schedule_ping()
    {:ok, state}
  end

  @impl true
  def handle_info(:ping_webhook, state) do
    IO.puts("[WebhookWorker] Executando ping para oban...")

    for i <- 1..10 do
      %{
        email: "ismael#{i}@example.com"
      }
      |> Pento.Worker.DeliverEmail.new()
      |> Oban.insert()
    end

    schedule_ping()

    {:noreply, state}
  end

  defp schedule_ping do
    Process.send_after(self(), :ping_webhook, @interval)
  end
end
