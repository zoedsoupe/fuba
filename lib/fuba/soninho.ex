defmodule Fuba.Soninho do
  @moduledoc "A casquinha do disco: salva e acorda a coelhinha."

  alias Fuba.{Coelhinha, Repo}
  alias Fuba.Soninho.Registro

  @id 1

  def salvar(%Coelhinha{} = c) do
    (Repo.get(Registro, @id) || %Registro{id: @id})
    |> Ecto.Changeset.change(Registro.de_coelhinha(c))
    |> Repo.insert_or_update()
  end

  def acordar do
    case Repo.get(Registro, @id) do
      nil -> %Coelhinha{}
      registro -> Registro.para_coelhinha(registro)
    end
  end
end
