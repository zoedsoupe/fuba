defmodule Fuba.Clima do
  @moduledoc "Rede é casquinha suja: parse na porta de entrada, fallback sempre."

  # Manhuaçu, MG: a casa dela
  @url "https://api.open-meteo.com/v1/forecast?latitude=-20.39&longitude=-42.03&current=weather_code"

  def como_ta_la_fora do
    case Req.get(@url, receive_timeout: 3_000) do
      {:ok, %{status: 200, body: %{"current" => %{"weather_code" => codigo}}}} ->
        {:ok, traduz(codigo)}

      _ ->
        {:error, :sem_sinal}
    end
  end

  # códigos WMO
  defp traduz(c) when c in [0, 1], do: :sol
  defp traduz(c) when c in [2, 3], do: :nublado
  defp traduz(c) when c in 51..67, do: :chuva
  defp traduz(c) when c in 80..82, do: :chuva
  defp traduz(c) when c in 95..99, do: :tempestade
  defp traduz(_), do: :tempo_doido
end
