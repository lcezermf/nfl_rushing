defmodule NflRushingWeb.PageViewTest do
  use NflRushingWeb.ConnCase, async: true

  alias NflRushingWeb.PageView

  describe "get_order_direction/1" do
    test "when no value is given must return asc" do
      assert PageView.get_order_direction("") == "asc"
    end

    test "when asc is given as param must return desc" do
      assert PageView.get_order_direction("asc") == "desc"
    end

    test "when desc is given as param must return asc" do
      assert PageView.get_order_direction("desc") == "asc"
    end
  end
end
