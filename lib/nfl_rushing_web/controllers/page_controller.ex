defmodule NflRushingWeb.PageController do
  use NflRushingWeb, :controller

  alias NflRushing.Stats

  def index(conn, _params) do
    players = Stats.list()

    render(conn, "index.html", players: players)
  end
end
