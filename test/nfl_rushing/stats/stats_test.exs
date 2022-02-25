defmodule NflRushing.StatsTest do
  use NflRushing.DataCase

  alias NflRushing.Factory
  alias NflRushing.Stats

  def player_factory(attrs \\ %{}), do: Factory.insert!(:player, attrs)

  describe "list/1" do
    test "with no data returns empty list" do
      assert Stats.list() == %Scrivener.Page{
               entries: [],
               page_number: 1,
               page_size: 25,
               total_entries: 0,
               total_pages: 1
             }
    end

    test "with data returns list" do
      player_factory()
      player_factory()

      refute Stats.list() == []
      assert Stats.list() |> Enum.count() == 2
    end

    test "with whole name param given as filter must filter by name" do
      player_one = player_factory(%{name: "Testing filter"})
      player_two = player_factory()

      records = Stats.list(%{"name_filter" => player_one.name})
      ids = Enum.map(records, fn record -> record.id end)

      assert Enum.count(records) == 1
      assert player_one.id in ids
      refute player_two.id in ids
    end

    test "with partial name param given as filter must filter by name" do
      player_one = player_factory(%{name: "Testing filter"})
      player_two = player_factory()
      player_three = player_factory(%{name: "Random filter"})

      records = Stats.list(%{"name_filter" => "Testing"})
      ids = Enum.map(records, fn record -> record.id end)

      assert Enum.count(records) == 1
      assert player_one.id in ids
      refute player_two.id in ids
      refute player_three.id in ids

      records = Stats.list(%{"name_filter" => "filter"})
      ids = Enum.map(records, fn record -> record.id end)

      assert Enum.count(records) == 2
      assert player_one.id in ids
      refute player_two.id in ids
      assert player_three.id in ids
    end

    test "order data by rushing_yards_total asc" do
      player_one = player_factory(%{rushing_yards_total: 10.0})
      player_two = player_factory(%{rushing_yards_total: 2.1})
      player_three = player_factory(%{rushing_yards_total: 5.2})

      records = Stats.list(%{"order_field" => "rushing_yards_total", "order_direction" => "asc"})

      assert player_two.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_one.id == Enum.at(records, 2).id
    end

    test "order data by rushing_yards_total desc" do
      player_one = player_factory(%{rushing_yards_total: 10.0})
      player_two = player_factory(%{rushing_yards_total: 2.1})
      player_three = player_factory(%{rushing_yards_total: 5.2})

      records = Stats.list(%{"order_field" => "rushing_yards_total", "order_direction" => "desc"})

      assert player_one.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_two.id == Enum.at(records, 2).id
    end

    test "order data by rushing_touchdowns_total asc" do
      player_one = player_factory(%{rushing_touchdowns_total: 10})
      player_two = player_factory(%{rushing_touchdowns_total: 2})
      player_three = player_factory(%{rushing_touchdowns_total: 5})

      records =
        Stats.list(%{"order_field" => "rushing_touchdowns_total", "order_direction" => "asc"})

      assert player_two.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_one.id == Enum.at(records, 2).id
    end

    test "order data by rushing_touchdowns_total desc" do
      player_one = player_factory(%{rushing_touchdowns_total: 10})
      player_two = player_factory(%{rushing_touchdowns_total: 2})
      player_three = player_factory(%{rushing_touchdowns_total: 5})

      records =
        Stats.list(%{"order_field" => "rushing_touchdowns_total", "order_direction" => "desc"})

      assert player_one.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_two.id == Enum.at(records, 2).id
    end

    test "order data by rushing_longest_touchdown asc" do
      player_one = player_factory(%{rushing_longest_touchdown: 10})
      player_two = player_factory(%{rushing_longest_touchdown: 2})
      player_three = player_factory(%{rushing_longest_touchdown: 5})

      records =
        Stats.list(%{"order_field" => "rushing_longest_touchdown", "order_direction" => "asc"})

      assert player_two.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_one.id == Enum.at(records, 2).id
    end

    test "order data by rushing_longest_touchdown desc" do
      player_one = player_factory(%{rushing_longest_touchdown: 10})
      player_two = player_factory(%{rushing_longest_touchdown: 2})
      player_three = player_factory(%{rushing_longest_touchdown: 5})

      records =
        Stats.list(%{"order_field" => "rushing_longest_touchdown", "order_direction" => "desc"})

      assert player_one.id == Enum.at(records, 0).id
      assert player_three.id == Enum.at(records, 1).id
      assert player_two.id == Enum.at(records, 2).id
    end

    test "with name param that does not match as filter must return empty list" do
      player_factory(%{name: "Testing filter"})
      player_factory()

      assert Stats.list(%{"name_filter" => "Not valid name"}) == %Scrivener.Page{
               entries: [],
               page_number: 1,
               page_size: 25,
               total_entries: 0,
               total_pages: 1
             }
    end

    test "with all_data as a param must return all data with no offset" do
      for i <- 0..30, i > 0, do: player_factory()

      # Default value is 25, set in lib/nfl_rushing/repo.ex
      paginated_records = Stats.list()
      assert Enum.count(paginated_records) == 25

      # Return all_data
      all_records = Stats.list(%{"all_data" => "true"})
      assert Enum.count(all_records) == 30
    end
  end

  describe "list_teams_by_yards/0" do
    test "must return total YDS grouped by team" do
      player_factory(%{name: "Testing A", team: "A", rushing_yards_total: 10.0})
      player_factory(%{name: "Testing B", team: "A", rushing_yards_total: 5.0})
      player_factory(%{name: "Testing C", team: "B", rushing_yards_total: 25.0})

      result = Stats.list_teams_by_yards()

      assert result == [
        %{team: "B", sum_rushing_yards_total: 25},
        %{team: "A", sum_rushing_yards_total: 15}
      ]
    end

    test "return empty" do
      assert Stats.list_teams_by_yards() == []
    end
  end
end
