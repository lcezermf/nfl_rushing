defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  alias NflRushing.Stats

  def index(conn, params) do
    players = Stats.list(params)

    render(conn, "index.html", players: players)
  end
end
