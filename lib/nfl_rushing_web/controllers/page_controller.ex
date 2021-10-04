defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  alias NflRushing.Stats
  alias NflRushing.Stats.CSVBuilder

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    players = Stats.list(params)

    render(conn, "index.html", players: players)
  end

  @spec export_data(Plug.Conn.t(), map) :: Plug.Conn.t()
  def export_data(conn, params) do
    players = Stats.list(params)

    send_download(
      conn,
      {:binary, CSVBuilder.build(players)},
      content_type: "application/csv",
      filename: "rushing.csv"
    )
  end
end
