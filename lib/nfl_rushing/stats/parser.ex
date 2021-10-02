defmodule NflRushing.Stats.Parser do
  @moduledoc """
  NflRushing.Stats.Parser is a module to parse information about a player by reading data from JSON.
  """

  @spec parse_players(binary()) :: {:ok, [map()]} | {:error, atom}
  def parse_players(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, parsed_json} <- Jason.decode(body) do
      {:ok, Enum.map(parsed_json, fn player -> parse_player(player) end)}
    end
  end

  @spec parse_player(map()) :: map()
  defp parse_player(player) do
    %{
      name: player["Player"],
      team: player["Team"],
      position: player["Pos"],
      rushing_attempts_per_game_average: player["Att/G"],
      rushing_attempts_total: player["Att"],
      rushing_yards_total: player["Yds"],
      rushing_yards_per_attempt_average: player["Avg"],
      rushing_yards_per_game: player["Yds/G"],
      rushing_touchdowns_total: player["TD"],
      rushing_longest_touchdown: player["Lng"],
      rushing_first_downs_total: player["1st"],
      rushing_first_downs_percentage: player["1st%"],
      rushing_20_yards_more: player["20+"],
      rushing_40_yards_more: player["40+"],
      fumbles: player["FUM"]
    }
  end
end
