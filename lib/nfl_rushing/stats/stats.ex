defmodule NflRushing.Stats do
  @moduledoc """
  NflRushing.Stats is the context that handles all stats related business logic, such as: list data,
  filter and search.
  """

  import Ecto.Query, warn: false

  alias NflRushing.Repo
  alias NflRushing.Stats.Player

  @doc """
  Retuns a list of players on the DB.

  If no params is set return all result on the DB.

  Allowed keys in the map params:

  * name_filter: a string that represents the name used to filter the data
  """
  @spec list(map()) :: [Player] | []
  def list(params \\ %{}) do
    Player
    |> filter_by_name(params)
    |> Repo.all()
  end

  defp filter_by_name(query, %{"name_filter" => name_filter}) do
    query
    |> where([player], like(player.name, ^"%#{name_filter}%"))
  end

  defp filter_by_name(query, %{}), do: query
end
