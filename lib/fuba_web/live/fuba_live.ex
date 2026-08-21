defmodule FubaWeb.FubaLive do
  use FubaWeb, :live_view

  alias Fuba.{Coelhinha, Cuidado, Humor}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, fuba: %Coelhinha{})}
  end

  @impl true
  def handle_event("cuidar", %{"acao" => acao}, socket) do
    acao = String.to_existing_atom(acao)
    {:noreply, update(socket, :fuba, &Cuidado.aplicar(&1, acao))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <main>
      <p class="carinha">{Humor.carinha(Cuidado.humor(@fuba))}</p>
      <h1>{@fuba.nome}</h1>
      <p class="humor">{frase(Cuidado.humor(@fuba))}</p>

      <div class="medidores">
        <div class="medidor">
          <span>biscoito</span>
          <span class={"barra #{if @fuba.biscoito <= 1, do: "baixa"}"}>{barrinha(@fuba.biscoito)}</span>
        </div>
        <div class="medidor">
          <span>cafeína</span>
          <span class={"barra #{if @fuba.cafeina <= 1, do: "baixa"}"}>{barrinha(@fuba.cafeina)}</span>
        </div>
        <div class="medidor">
          <span>carinho</span>
          <span class={"barra #{if @fuba.carinho <= 1, do: "baixa"}"}>{barrinha(@fuba.carinho)}</span>
        </div>
        <div class="medidor">
          <span>energia</span>
          <span class={"barra #{if @fuba.energia <= 1, do: "baixa"}"}>{barrinha(@fuba.energia)}</span>
        </div>
      </div>

      <div class="acoes">
        <button phx-click="cuidar" phx-value-acao="biscoito">🍪 biscoito</button>
        <button phx-click="cuidar" phx-value-acao="cafe">☕ café</button>
        <button phx-click="cuidar" phx-value-acao="cafune">🫶 cafuné</button>
        <button phx-click="cuidar" phx-value-acao="espaco">🍃 espaço</button>
      </div>
    </main>
    """
  end

  defp barrinha(n), do: String.duplicate("■", n) <> String.duplicate("□", 5 - n)

  defp frase(:feliz), do: "tudo certo por aqui"
  defp frase(:chatinha), do: "tá chatinha… cadê o café?"
  defp frase(:desregulada), do: "desregulada. só espaço ajuda."
  defp frase(:go_queen), do: "GO QUEEN!"
end
