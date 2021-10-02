defmodule NflRushing.StatsTest do
  use NflRushing.DataCase

  alias NflRushing.Stats

  describe "list/1" do
    test "when no data is loaded return empty list" do
      assert [] == Stats.list()
    end

    test "when data is loaded return list with data" do
      {:ok, result} = NflRushing.Stats.Parser.parse_players("test/support/fixtures/rushing.json")

      NflRushing.Repo.insert_all(NflRushing.Stats.Player, result)

      refute [] == Stats.list()
      assert Stats.list() |> Enum.count() == 2
    end
  end
end