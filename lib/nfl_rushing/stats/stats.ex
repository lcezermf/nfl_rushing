defmodule NflRushing.Stats do
  @moduledoc """
  NflRushing.Stats is the context that handles all stats related business logic, such as: list data,
  filter and search.
  """

  import Ecto.Query, warn: false

  alias NflRushing.Repo
  alias NflRushing.Stats.Player

  @spec list(name_filter :: String.t()) :: [Player] | []
  def list(name_filter \\ "") do
    Player
    |> filter_by_name(name_filter)
    |> Repo.all()
  end

  defp filter_by_name(query, ""), do: query

  defp filter_by_name(query, name_filter) do
    query
    |> where([player], like(player.name, ^"%#{name_filter}%"))
  end
end
