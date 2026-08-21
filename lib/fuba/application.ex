defmodule Fuba.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, scheme: :http, plug: FubaWeb.Plug, port: 4000}
    ]

    opts = [strategy: :one_for_one, name: Fuba.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
