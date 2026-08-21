defmodule Fuba.Repo do
  use Ecto.Repo, otp_app: :fuba_web, adapter: Ecto.Adapters.SQLite3
end
