defmodule NflRushing.Stats.ParserTest do
  use NflRushing.DataCase

  alias NflRushing.Stats.Parser

  describe "parse_players/1" do
    test "with invalid file path must raise error" do
      assert {:error, :enoent} == Parser.parse_players("invalid_file_path.json")
    end

    test "must map columns from JSON and map to Player schema" do
      expected_players = [
        %{
          fumbles: 0,
          name: "Joe Banyard",
          position: "RB",
          rushing_20_yards_more: 0,
          rushing_40_yards_more: 0,
          rushing_attempts_per_game_average: 2,
          rushing_attempts_total: 2,
          rushing_first_downs_percentage: 0,
          rushing_first_downs_total: 0,
          rushing_longest_touchdown: 7,
          rushing_longest_touchdown_raw: "7",
          rushing_touchdowns_total: 0,
          rushing_yards_per_attempt_average: 3.5,
          rushing_yards_per_game: 7,
          rushing_yards_total: 7,
          team: "JAX"
        },
        %{
          fumbles: 2,
          name: "Mark Ingram",
          position: "RB",
          rushing_20_yards_more: 4,
          rushing_40_yards_more: 2,
          rushing_attempts_per_game_average: 12.8,
          rushing_attempts_total: 205,
          rushing_first_downs_percentage: 23.9,
          rushing_first_downs_total: 49,
          rushing_longest_touchdown: 75,
          rushing_longest_touchdown_raw: "75T",
          rushing_touchdowns_total: 6,
          rushing_yards_per_attempt_average: 5.1,
          rushing_yards_per_game: 65.2,
          rushing_yards_total: 1.043,
          team: "NO"
        }
      ]

      assert {:ok, expected_players} == Parser.parse_players("test/support/fixtures/rushing.json")
    end
  end
end
