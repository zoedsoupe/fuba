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

  post "/cuidar" do
    {:ok, corpo, conn} = Plug.Conn.read_body(conn)
    %{"acao" => acao} = Plug.Conn.Query.decode(corpo)

    Fuba.Guarda.atualizar(&Fuba.Cuidado.aplicar(&1, String.to_existing_atom(acao)))

    conn
    |> put_resp_header("location", "/")
    |> send_resp(303, "")
  end

  match _ do
    send_resp(conn, 404, "nada aqui, uai")
  end
end
