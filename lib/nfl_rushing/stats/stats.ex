defmodule NflRushing.Stats do
  @moduledoc """
  NflRushing.Stats is the context that handles all stats related business logic, such as: list data,
  filter and search.
  """

  import Ecto.Query, warn: false

  alias NflRushing.Repo
  alias NflRushing.Stats.Player

  @doc """
  Retuns a list of players

  If no params is set return all results.

  Allowed keys in the map params:

  * name_filter: a string that represents the name used to filter the data
  * order_field: the field used to apply the order
  * order_direction: if the order is by :asc or :desc
  * all_data: if set to true return all data in the db, if not return the filterd/sorted ones
  """
  @spec list(map()) ::
          %Scrivener.Page{
            :entries => [Player],
            :page_number => pos_integer(),
            :page_size => integer(),
            :total_entries => integer(),
            :total_pages => pos_integer()
          }
          | [Player]
  def list(params \\ %{}) do
    result =
      Player
      |> filter_by_name(params)
      |> apply_order(params)

    if Map.has_key?(params, "all_data") do
      Repo.all(result)
    else
      Repo.paginate(result, params)
    end
  end

  @spec filter_by_name(Ecto.Queryable.t(), map()) :: Ecto.Queryable.t()
  defp filter_by_name(query, %{"name_filter" => name_filter}) do
    query
    |> where([player], ilike(player.name, ^"%#{name_filter}%"))
  end

  defp filter_by_name(query, %{}), do: query

  @spec apply_order(Ecto.Queryable.t(), map()) :: Ecto.Queryable.t()
  defp apply_order(query, %{"order_field" => order_field, "order_direction" => order_direction})
       when order_field != "" and order_direction != "" do
    query
    |> order_by(
      [player],
      {^String.to_atom(order_direction), field(player, ^String.to_atom(order_field))}
    )
  end

  defp apply_order(query, %{}), do: query
end
