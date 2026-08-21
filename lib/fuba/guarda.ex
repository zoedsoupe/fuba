defmodule Fuba.Guarda do
  @moduledoc "A caixinha que guarda a coelhinha (Agent pragmático, teoria vem no post 8)."

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %Fuba.Coelhinha{} end, name: __MODULE__)
  end

  def espiar, do: Agent.get(__MODULE__, & &1)
  def atualizar(fun), do: Agent.update(__MODULE__, fun)
end
