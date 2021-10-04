defmodule NflRushingWeb.PageView do
  use NflRushingWeb, :view

  @spec get_order_direction(binary()) :: binary()
  def get_order_direction(""), do: "asc"
  def get_order_direction("asc"), do: "desc"
  def get_order_direction("desc"), do: "asc"
end
