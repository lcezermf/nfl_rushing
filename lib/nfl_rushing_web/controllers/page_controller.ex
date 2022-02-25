defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  alias NflRushing.Stats
  alias NflRushing.Stats.CSVBuilder

  plug NflRushingWeb.Plugs.ValidateOrderParams when action in [:index]

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, params) do
    paginator = Stats.list(params)

    render(conn, "index.html",
      players: paginator.entries,
      page_number: paginator.page_number,
      page_size: paginator.page_size,
      page: paginator
    )
  end

  def teams(conn, _params) do
    records = Stats.list_teams_by_yards()

    render(conn, "teams.html", records: records)
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
