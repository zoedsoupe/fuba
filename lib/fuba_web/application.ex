defmodule FubaWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FubaWeb.Telemetry,
      {Phoenix.PubSub, name: Fuba.PubSub},
      Fuba.Convivencia,
      # Start to serve requests, typically the last entry
      FubaWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: FubaWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FubaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
