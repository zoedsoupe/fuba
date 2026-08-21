defmodule Fuba.Convivencia do
  @moduledoc "A Fubá única, viva em tempo real: um GenServer pra todo mundo."

  use GenServer

  alias Fuba.{Coelhinha, Cuidado}

  @intervalo 10_000

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %Coelhinha{}, name: __MODULE__)
  end

  def espiar, do: GenServer.call(__MODULE__, :espiar)
  def cuidar(acao), do: GenServer.call(__MODULE__, {:cuidar, acao})

  @impl true
  def init(_fuba) do
    :timer.send_interval(@intervalo, :tempo_passa)
    {:ok, Fuba.Soninho.acordar()}
  end

  @impl true
  def handle_call(:espiar, _de, fuba), do: {:reply, fuba, fuba}

  def handle_call({:cuidar, acao}, _de, fuba) do
    nova = Cuidado.aplicar(fuba, acao)
    Fuba.Soninho.salvar(nova)
    avisar(nova)
    {:reply, nova, nova}
  end

  @impl true
  def handle_info(:tempo_passa, fuba) do
    nova = Cuidado.tempo_passa(fuba)
    Fuba.Soninho.salvar(nova)
    avisar(nova)
    {:noreply, nova}
  end

  defp avisar(fuba) do
    Phoenix.PubSub.broadcast(Fuba.PubSub, "fuba", {:fuba_mudou, fuba})
  end
end
