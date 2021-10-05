defmodule NflRushing.Stats.CSVBuilderTest do
  use NflRushing.DataCase

  alias NflRushing.Factory
  alias NflRushing.Stats.CSVBuilder

  def player_factory(attrs \\ %{}), do: Factory.build(:player, attrs)

  describe "build/1" do
    test "with a list of players must return the raw data with headers and players data" do
      player_one =
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

      player_two =
        player_factory(%{
          id: 10,
          fumbles: 0,
          name: "Mark Ingram",
          position: "RB",
          rushing_20_yards_more: 0,
          rushing_40_yards_more: 0,
          rushing_attempts_per_game_average: 2.0,
          rushing_attempts_total: 2,
          rushing_first_downs_percentage: 0.0,
          rushing_first_downs_total: 0,
          rushing_longest_touchdown: 75,
          rushing_longest_touchdown_raw: "75T",
          rushing_touchdowns_total: 0,
          rushing_yards_per_attempt_average: 3.5,
          rushing_yards_per_game: 7.0,
          rushing_yards_total: 7.0,
          team: "NO"
        })

      assert CSVBuilder.build([player_one, player_two]) ==
               "ID,Player,Team,Pos,Att/G,Att,Yds,Avg,Yds/G,TD,Lng,Lng,1st,1st%,20+,40+,FUM\n#{player_one.id},#{player_one.name},#{player_one.team},#{player_one.position},#{player_one.rushing_attempts_per_game_average},#{player_one.rushing_attempts_total},#{player_one.rushing_yards_total},#{player_one.rushing_yards_per_attempt_average},#{player_one.rushing_yards_per_game},#{player_one.rushing_touchdowns_total},#{player_one.rushing_longest_touchdown},#{player_one.rushing_longest_touchdown_raw},#{player_one.rushing_first_downs_total},#{player_one.rushing_first_downs_percentage},#{player_one.rushing_20_yards_more},#{player_one.rushing_40_yards_more},#{player_one.fumbles}\n#{player_two.id},#{player_two.name},#{player_two.team},#{player_two.position},#{player_two.rushing_attempts_per_game_average},#{player_two.rushing_attempts_total},#{player_two.rushing_yards_total},#{player_two.rushing_yards_per_attempt_average},#{player_two.rushing_yards_per_game},#{player_two.rushing_touchdowns_total},#{player_two.rushing_longest_touchdown},#{player_two.rushing_longest_touchdown_raw},#{player_two.rushing_first_downs_total},#{player_two.rushing_first_downs_percentage},#{player_two.rushing_20_yards_more},#{player_two.rushing_40_yards_more},#{player_two.fumbles}\n"
    end
  end
end
