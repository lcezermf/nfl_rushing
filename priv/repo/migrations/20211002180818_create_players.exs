defmodule NflRushing.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :team, :string
      add :position, :string
      add :rushing_attempts_per_game_average, :float
      add :rushing_attempts_total, :integer
      add :rushing_yards_total, :float
      add :rushing_yards_per_attempt_average, :float
      add :rushing_yards_per_game, :float
      add :rushing_touchdowns_total, :integer
      add :rushing_longest_touchdown, :string
      add :rushing_first_downs_total, :integer
      add :rushing_first_downs_percentage, :float
      add :rushing_20_yards_more, :integer
      add :rushing_40_yards_more, :integer
      add :fumbles, :integer

      timestamps()
    end

    create index(:players, :rushing_yards_total)
    create index(:players, :rushing_longest_touchdown)
    create index(:players, :rushing_touchdowns_total)
    create index(:players, :name)
  end
end
