defmodule NflRushing.Stats.Player do
  @moduledoc """
  NflRushing.Stats.Player is a module to handle information about a single player.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @default_fields [
    :name,
    :team,
    :position,
    :rushing_attempts_per_game_average,
    :rushing_attempts_total,
    :rushing_yards_total,
    :rushing_yards_per_attempt_average,
    :rushing_yards_per_game,
    :rushing_touchdowns_total,
    :rushing_longest_touchdown,
    :rushing_longest_touchdown_raw,
    :rushing_first_downs_total,
    :rushing_first_downs_percentage,
    :rushing_20_yards_more,
    :rushing_40_yards_more,
    :fumbles
  ]

  schema "players" do
    field :name, :string
    field :team, :string
    field :position, :string
    field :rushing_attempts_per_game_average, :float
    field :rushing_attempts_total, :integer
    field :rushing_yards_total, :float
    field :rushing_yards_per_attempt_average, :float
    field :rushing_yards_per_game, :float
    field :rushing_touchdowns_total, :integer
    field :rushing_longest_touchdown, :integer
    field :rushing_longest_touchdown_raw, :string
    field :rushing_first_downs_total, :integer
    field :rushing_first_downs_percentage, :float
    field :rushing_20_yards_more, :integer
    field :rushing_40_yards_more, :integer
    field :fumbles, :integer
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(player, attrs) do
    player
    |> cast(attrs, @default_fields)
    |> validate_required(@default_fields)
  end
end
