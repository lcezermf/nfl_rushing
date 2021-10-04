defmodule NflRushing.Stats.CSVBuilderTest do
  use NflRushing.DataCase

  alias NflRushing.Factory
  alias NflRushing.Stats.CSVBuilder

  def player_factory(attrs \\ %{}), do: Factory.build(:player, attrs)

  describe "build/1" do
    test "returns headers" do
      player =
        player_factory(%{
          id: 1,
          fumbles: 0,
          name: "Joe Banyard",
          position: "RB",
          rushing_20_yards_more: 0,
          rushing_40_yards_more: 0,
          rushing_attempts_per_game_average: 2.0,
          rushing_attempts_total: 2,
          rushing_first_downs_percentage: 0.0,
          rushing_first_downs_total: 0,
          rushing_longest_touchdown: 7,
          rushing_longest_touchdown_raw: "7",
          rushing_touchdowns_total: 0,
          rushing_yards_per_attempt_average: 3.5,
          rushing_yards_per_game: 7.0,
          rushing_yards_total: 7.0,
          team: "JAX"
        })

      assert CSVBuilder.build([player]) ==
               "ID,Player,Team,Pos,Att/G,Att,Yds,Avg,Yds/G,TD,Lng,Lng,1st,1st%,20+,40+,FUM\n#{player.id},#{player.name},#{player.team},#{player.position},#{player.rushing_attempts_per_game_average},#{player.rushing_attempts_total},#{player.rushing_yards_total},#{player.rushing_yards_per_attempt_average},#{player.rushing_yards_per_game},#{player.rushing_touchdowns_total},#{player.rushing_longest_touchdown},#{player.rushing_longest_touchdown_raw},#{player.rushing_first_downs_total},#{player.rushing_first_downs_percentage},#{player.rushing_20_yards_more},#{player.rushing_40_yards_more},#{player.fumbles}\n"
    end
  end
end
