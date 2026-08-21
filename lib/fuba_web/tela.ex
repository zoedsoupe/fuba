defmodule FubaWeb.Tela do
  require EEx

  EEx.function_from_file(:defp, :render_eex, "lib/fuba_web/tela.html.eex", [:assigns])

  def render(fuba), do: render_eex(%{fuba: fuba})

  def barrinha(n), do: String.duplicate("■", n) <> String.duplicate("□", 5 - n)

  def frase(:feliz), do: "tudo certo por aqui"
  def frase(:chatinha), do: "tá chatinha… cadê o café?"
  def frase(:desregulada), do: "desregulada. só espaço ajuda."
  def frase(:go_queen), do: "GO QUEEN!"
  def frase(_), do: "…"
end
