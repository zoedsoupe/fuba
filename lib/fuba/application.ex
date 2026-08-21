defmodule Fuba.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [Fuba.Guarda] ++
        if Mix.env() == :test do
          []
        else
          [{Bandit, scheme: :http, plug: FubaWeb.Router, port: 4000}]
        end

    opts = [strategy: :one_for_one, name: Fuba.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
