defmodule NflRushing.Stats.PlayerTest do
  use NflRushing.DataCase

  alias NflRushing.Stats.Player

  @valid_fields %{
    name: "Some player",
    team: "MyTeam",
    position: "MyPosition",
    rushing_attempts_per_game_average: 0.1,
    rushing_attempts_total: 10,
    rushing_yards_total: 15,
    rushing_yards_per_attempt_average: 56.2,
    rushing_yards_per_game: 1.0,
    rushing_touchdowns_total: 10,
    rushing_longest_touchdown: 10,
    rushing_longest_touchdown_raw: "10T",
    rushing_first_downs_total: 55,
    rushing_first_downs_percentage: 10.2,
    rushing_20_yards_more: 5,
    rushing_40_yards_more: 10,
    fumbles: 1
  }

  describe "changeset/2" do
    test "with valid data and return valid changeset" do
      changeset = Player.changeset(%Player{}, @valid_fields)

      assert changeset.valid?
    end

    test "with an invalid data and return changeset errors" do
      invalid_fields = Map.merge(@valid_fields, %{fumbles: nil, rushing_40_yards_more: "nil"})

      changeset = Player.changeset(%Player{}, invalid_fields)

      refute changeset.valid?

      assert "can't be blank" in errors_on(changeset).fumbles
      assert "is invalid" in errors_on(changeset).rushing_40_yards_more
    end
  end
end
