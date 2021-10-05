defmodule NflRushing.Stats.CSVBuilder do
  @moduledoc """
  NflRushing.Stats.CSVBuilder is a module responsible to build the data that will be used on the CSV file exported.
  """

  alias NflRushing.Stats.Player

  @doc """
  Returns a prepared raw data to be exported as CSV by a controller action.
  """
  @spec build([Player]) :: binary()
  def build(players) do
    headers =
      [
        "ID",
        "Player",
        "Team",
        "Pos",
        "Att/G",
        "Att",
        "Yds",
        "Avg",
        "Yds/G",
        "TD",
        "Lng",
        "Lng",
        "1st",
        "1st%",
        "20+",
        "40+",
        "FUM"
      ]
      |> Enum.join(",")

    players = Enum.map(players, &Player.to_csv(&1))

    Enum.join([headers, players], "\n")
  end
end
