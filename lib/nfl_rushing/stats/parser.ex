defmodule NflRushing.Stats.Parser do
  @moduledoc """
  NflRushing.Stats.Parser is a module to parse information about a player by reading data from JSON.
  """

  @doc """
  Returns parsed data from a JSON file into a map with mapped values to build Stats.Player schema.

  If invalid filename or filepath is give, returns error.
  """
  @spec parse_players(binary()) :: {:ok, [map()]} | {:error, atom}
  def parse_players(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, parsed_json_data} <- Jason.decode(body) do
      {:ok, Enum.map(parsed_json_data, fn player -> parse_player(player) end)}
    end
  end

  @spec parse_player(map()) :: map()
  defp parse_player(player) do
    %{
      name: player["Player"],
      team: player["Team"],
      position: player["Pos"],
      rushing_attempts_per_game_average: to_float(player["Att/G"]),
      rushing_attempts_total: player["Att"],
      rushing_yards_total: to_float(player["Yds"]),
      rushing_yards_per_attempt_average: to_float(player["Avg"]),
      rushing_yards_per_game: to_float(player["Yds/G"]),
      rushing_touchdowns_total: player["TD"],
      rushing_longest_touchdown: to_integer(player["Lng"]),
      rushing_longest_touchdown_raw: "#{player["Lng"]}",
      rushing_first_downs_total: player["1st"],
      rushing_first_downs_percentage: to_float(player["1st%"]),
      rushing_20_yards_more: player["20+"],
      rushing_40_yards_more: player["40+"],
      fumbles: player["FUM"]
    }
  end

  @spec to_float(binary()) :: float()
  defp to_float(value) when is_binary(value) do
    replaced_value = String.replace(value, ",", ".")
    {float_value, _} = Float.parse(replaced_value)
    float_value
  end

  @spec to_float(number()) :: float()
  defp to_float(value), do: value * 100 / 100

  @spec to_integer(String.t()) :: integer()
  defp to_integer(value) when is_binary(value) do
    value
    |> String.replace("T", "")
    |> String.to_integer()
  end

  @spec to_integer(integer()) :: integer()
  defp to_integer(value) when is_integer(value), do: value
end
