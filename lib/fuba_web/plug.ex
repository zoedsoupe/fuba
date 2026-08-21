defmodule FubaWeb.Plug do
  use Plug.Builder

  plug Plug.Static, at: "/", from: :fuba

  plug :nao_achei

  def nao_achei(conn, _opts) do
    send_resp(conn, 404, "nada aqui, uai")
  end
end
