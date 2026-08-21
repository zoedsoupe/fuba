defmodule Fuba.Soninho.Registro do
  @moduledoc "A ficha de anamnese: traduz entre o banco e o coração. A ficha não é o paciente."

  use Ecto.Schema

  alias Fuba.Coelhinha

  schema "coelhinha" do
    field :nome, :string
    field :biscoito, :integer
    field :cafeina, :integer
    field :carinho, :integer
    field :energia, :integer
  end

  @campos [:nome, :biscoito, :cafeina, :carinho, :energia]

  def de_coelhinha(%Coelhinha{} = c), do: Map.take(c, @campos)
  def para_coelhinha(%__MODULE__{} = r), do: struct(Coelhinha, Map.take(r, @campos))
end
