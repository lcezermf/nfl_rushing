defmodule NflRushingWeb.Plugs.ValidateOrderParams do
  @moduledoc """
  NflRushingWeb.Plugs.ValidateOrderParams is a plug to validate params for order_field and order_direction
  """

  use Phoenix.Controller
  import Plug.Conn

  alias NflRushingWeb.Router.Helpers

  @valid_order_fields [
    "rushing_yards_total",
    "rushing_touchdowns_total",
    "rushing_longest_touchdown"
  ]
  @valid_order_directions ["asc", "desc"]

  def init(_params) do
  end

  def call(conn, _opts) do
    cond do
      invalid_order_field?(conn.params) ->
        conn
        |> put_flash(
          :error,
          "Invalid order field: must be #{Enum.join(@valid_order_fields, ", ")}"
        )
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()

      invalid_order_direction?(conn.params) ->
        conn
        |> put_flash(
          :error,
          "Invalid order direction: must be #{Enum.join(@valid_order_directions, ", ")}"
        )
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()

      true ->
        conn
    end
  end

  defp invalid_order_field?(params) do
    Map.has_key?(params, "order_field") and params["order_field"] != "" and
      !Enum.member?(@valid_order_fields, params["order_field"])
  end

  defp invalid_order_direction?(params) do
    Map.has_key?(params, "order_direction") and params["order_direction"] != "" and
      !Enum.member?(@valid_order_directions, params["order_direction"])
  end
end
