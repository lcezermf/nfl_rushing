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

  describe "to_csv/1" do
    test "with valid data must return all fields as a string separated with comma" do
      assert Player.to_csv(Map.merge(@valid_fields, %{id: 1})) ==
               "1,#{@valid_fields.name},#{@valid_fields.team},#{@valid_fields.position},#{@valid_fields.rushing_attempts_per_game_average},#{@valid_fields.rushing_attempts_total},#{@valid_fields.rushing_yards_total},#{@valid_fields.rushing_yards_per_attempt_average},#{@valid_fields.rushing_yards_per_game},#{@valid_fields.rushing_touchdowns_total},#{@valid_fields.rushing_longest_touchdown},#{@valid_fields.rushing_longest_touchdown_raw},#{@valid_fields.rushing_first_downs_total},#{@valid_fields.rushing_first_downs_percentage},#{@valid_fields.rushing_20_yards_more},#{@valid_fields.rushing_40_yards_more},#{@valid_fields.fumbles}\n"
    end

    test "with empty map returns and empty string" do
      assert Player.to_csv(%{}) == ""
    end
  end
end
