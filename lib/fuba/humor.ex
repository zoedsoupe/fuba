defmodule Fuba.Humor do
  alias Fuba.Cuidado

  @spec carinha(Cuidado.humor() | atom()) :: String.t()
  def carinha(:feliz), do: "( ᵔ ᴥ ᵔ )"
  def carinha(:chatinha), do: "( ￣^￣)"
  def carinha(:desregulada), do: "( ; ᴥ ; )"
  def carinha(:go_queen), do: "\\(ᵔᴥᵔ)/"
  def carinha(_desconhecido), do: "( o.o )"
end
