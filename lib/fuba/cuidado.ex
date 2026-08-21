defmodule Fuba.Cuidado do
  @moduledoc """
  O coração da Fubá: 100% puro, zero IO, HTTP, HTML ou Ecto.
  Toda casquinha (web) é intercambiável sem tocar aqui.
  """

  alias Fuba.Coelhinha

  @type acao :: :biscoito | :cafe | :cafune | :espaco
  @type humor :: :feliz | :chatinha | :desregulada | :go_queen

  @spec dar_biscoito(Coelhinha.t()) :: Coelhinha.t()
  def dar_biscoito(%Coelhinha{} = c), do: %{c | biscoito: limita(c.biscoito + 2)}

  @spec dar_cafe(Coelhinha.t()) :: Coelhinha.t()
  def dar_cafe(%Coelhinha{} = c), do: %{c | cafeina: limita(c.cafeina + 2)}

  @spec fazer_cafune(Coelhinha.t()) :: Coelhinha.t()
  def fazer_cafune(%Coelhinha{} = c), do: %{c | carinho: limita(c.carinho + 2)}

  @spec dar_espaco(Coelhinha.t()) :: Coelhinha.t()
  def dar_espaco(%Coelhinha{} = c) do
    %{c | energia: limita(c.energia + 2), carinho: limita(c.carinho - 1)}
  end

  @spec humor(Coelhinha.t()) :: humor()
  def humor(%Coelhinha{} = c) do
    medidores = [c.biscoito, c.cafeina, c.carinho, c.energia]

    cond do
      Enum.count(medidores, &(&1 == 0)) >= 2 -> :desregulada
      Enum.all?(medidores, &(&1 >= 4)) -> :go_queen
      Enum.any?(medidores, &(&1 == 0)) -> :chatinha
      true -> :feliz
    end
  end

  @spec aplicar(Coelhinha.t(), acao()) :: Coelhinha.t()
  def aplicar(%Coelhinha{} = c, acao) do
    if humor(c) == :desregulada and acao != :espaco do
      c
    else
      case acao do
        :biscoito -> dar_biscoito(c)
        :cafe -> dar_cafe(c)
        :cafune -> fazer_cafune(c)
        :espaco -> dar_espaco(c)
      end
    end
  end

  @spec tempo_passa(Coelhinha.t()) :: Coelhinha.t()
  def tempo_passa(%Coelhinha{} = c) do
    %{c |
      biscoito: limita(c.biscoito - 1),
      cafeina: limita(c.cafeina - 1),
      carinho: limita(c.carinho - 1),
      energia: limita(c.energia - 1)}
  end

  # pública pra ser testável; detalhe interno
  @spec limita(integer()) :: integer()
  def limita(n), do: n |> max(0) |> min(5)
end
