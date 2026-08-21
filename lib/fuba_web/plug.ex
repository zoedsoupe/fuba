defmodule FubaWeb.Plug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain; charset=utf-8")
    |> send_resp(200, "a Fubá tá te ouvindo")
  end
end
