defmodule NflRushing.Stats do
  @moduledoc """
  NflRushing.Stats is the context that handles all stats related business logic, such as: list data,
  filter and search.
  """

  alias NflRushing.Repo
  alias NflRushing.Stats.Player

  @spec list() :: [Player] | []
  def list(), do: Repo.all(Player)
end
