defmodule NflRushingWeb.Plugs.ValidateOrderParamsTest do
  use NflRushingWeb.ConnCase, async: true

  alias NflRushingWeb.Plugs.ValidateOrderParams

  test "init/1 must return params" do
    assert nil == ValidateOrderParams.init(%{})
  end

  describe "call/2" do
    test "with valid order_field must return 200", %{conn: conn} do
      conn = get(conn, "/?order_field=rushing_yards_total")
      assert response(conn, 200)

      conn = get(conn, "/?order_field=rushing_touchdowns_total")
      assert response(conn, 200)

      conn = get(conn, "/?order_field=rushing_longest_touchdown")
      assert response(conn, 200)
    end

    test "with invalid order_field must halt connection and return flash error", %{conn: conn} do
      conn = get(conn, "/?order_field=invalid")

      assert get_flash(conn, :error) =~ "Invalid order field"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert conn.halted()
    end

    test "with valid order_direction must return 200", %{conn: conn} do
      conn = get(conn, "/?order_direction=asc")
      assert response(conn, 200)

      conn = get(conn, "/?order_direction=desc")
      assert response(conn, 200)
    end

    test "with invalid order_direction must halt connection and return flash error", %{conn: conn} do
      conn = get(conn, "/?order_direction=invalid")

      assert get_flash(conn, :error) =~ "Invalid order direction"
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert conn.halted()
    end
  end
end
