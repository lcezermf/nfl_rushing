defmodule NflRushing.Stats.Player do
  @moduledoc """
  NflRushing.Stats.Player is a schema to handle information about a Player.
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

  @doc """
  Returns all values from a map joined with comma.
  """
  @spec to_csv(map()) :: String.t()
  def to_csv(fields) when fields == %{}, do: ""

  def to_csv(fields) do
    "#{fields.id},#{fields.name},#{fields.team},#{fields.position},#{fields.rushing_attempts_per_game_average},#{fields.rushing_attempts_total},#{fields.rushing_yards_total},#{fields.rushing_yards_per_attempt_average},#{fields.rushing_yards_per_game},#{fields.rushing_touchdowns_total},#{fields.rushing_longest_touchdown},#{fields.rushing_longest_touchdown_raw},#{fields.rushing_first_downs_total},#{fields.rushing_first_downs_percentage},#{fields.rushing_20_yards_more},#{fields.rushing_40_yards_more},#{fields.fumbles}\n"
  end
end
