defmodule NflRushing.Stats.CSVBuilder do
  @moduledoc """
  NflRushing.Stats.CSVBuilder is a module responsible to build the CSV with data to be exported.
  """

  alias NflRushing.Stats.Player

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
