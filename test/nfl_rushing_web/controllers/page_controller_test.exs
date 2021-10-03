defmodule NflRushingWeb.PageControllerTest do
  use NflRushingWeb.ConnCase

  alias NflRushing.Factory

  def player_factory(attrs \\ %{}), do: Factory.insert!(:player, attrs)

  test "GET / with no data returns not found message", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Player not found"
    assert html_response(conn, 200) =~ "Welcome to NFL Rushing!"
  end

  test "GET / with data returns listing players message", %{conn: conn} do
    player_factory()

    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Listing players"
    assert html_response(conn, 200) =~ "Welcome to NFL Rushing!"
  end

  test "GET / with name as filter data returns listing players message and filtered player", %{
    conn: conn
  } do
    player_factory(%{name: "Must filter this one"})
    player_factory(%{name: "Must not filter this one"})

    conn = get(conn, "/", %{"name_filter" => "Must filter"})

    refute html_response(conn, 200) =~ "Must not"
    assert html_response(conn, 200) =~ "Must filter"
    assert html_response(conn, 200) =~ "Listing players"
    assert html_response(conn, 200) =~ "Welcome to NFL Rushing!"
  end

  test "GET / with accepts name_filter, order_field and order_direction as query string args", %{
    conn: conn
  } do
    player_factory(%{name: "Must filter this one", rushing_yards_total: 10.0})
    player_factory(%{name: "Must not filter this one", rushing_yards_total: 5.1})

    conn =
      get(conn, "/", %{
        "name_filter" => "Must filter",
        "order_field" => "rushing_yards_total",
        "order_direction" => "asc"
      })

    refute html_response(conn, 200) =~ "Must not"
    assert html_response(conn, 200) =~ "Must filter"
    assert html_response(conn, 200) =~ "Listing players"
    assert html_response(conn, 200) =~ "Welcome to NFL Rushing!"
  end
end
