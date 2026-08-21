defmodule FubaWeb.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    corpo = FubaWeb.Tela.render(Fuba.Guarda.espiar())

    conn
    |> put_resp_content_type("text/html; charset=utf-8")
    |> send_resp(200, corpo)
  end

  match _ do
    send_resp(conn, 404, "nada aqui, uai")
  end
end
