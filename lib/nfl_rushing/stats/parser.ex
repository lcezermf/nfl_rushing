defmodule NflRushing.Stats.Parser do
  @moduledoc """
  NflRushing.Stats.Parser is a module to parse information about a player by reading data from JSON.
  """


  @spec parse_players(binary()) :: {:ok, [map()]} | {:error, atom}
  def parse_players(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, _parsed_json} <- Jason.decode(body)
    do
      {:ok, %{}}
    end
  end
end
