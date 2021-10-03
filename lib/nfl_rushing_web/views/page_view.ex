defmodule NflRushingWeb.PageView do
  use NflRushingWeb, :view

  def get_order_direction(""), do: "asc"
  def get_order_direction("asc"), do: "desc"
  def get_order_direction("desc"), do: "asc"
end
