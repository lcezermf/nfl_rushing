defmodule NflRushing.Factory do
  @moduledoc """
  NflRushing.Factory enables creation of factories in tests
  """

  alias NflRushing.Repo

  def build(:player) do
    %NflRushing.Stats.Player{
      name: "Player ##{System.unique_integer()}",
      team: "Team ##{System.unique_integer()}",
      position: Enum.random(["C", "OG", "R", "QB", "TE"]),
      rushing_attempts_per_game_average: generate_random_float(),
      rushing_attempts_total: :rand.uniform(100),
      rushing_yards_total: generate_random_float(),
      rushing_yards_per_attempt_average: generate_random_float(),
      rushing_yards_per_game: generate_random_float(),
      rushing_touchdowns_total: :rand.uniform(100),
      rushing_longest_touchdown: generate_random_float(),
      rushing_first_downs_total: :rand.uniform(100),
      rushing_first_downs_percentage: generate_random_float(),
      rushing_20_yards_more: :rand.uniform(100),
      rushing_40_yards_more: :rand.uniform(100),
      fumbles: :rand.uniform(100)
    }
  end

  defp generate_random_float do
    ((Range.new(1, 100) |> Enum.random()) * 1.0) * 0.95 |> Float.round(2)
  end

  def build(factory_name, attributes) do
    factory_name
    |> build()
    |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name
    |> build(attributes)
    |> Repo.insert!()
  end
end
