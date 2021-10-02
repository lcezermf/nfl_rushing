defmodule NflRushing.Stats.ParserTest do
  use NflRushing.DataCase

  alias NflRushing.Stats.Parser

  describe "parse_players/1" do
    test "with invalid file path must raise error" do
      assert Parser.parse_players("invalid_file_path.json") == {:error, :enoent}
    end

    test "with valid file path must return parsed line into a player" do
      assert Parser.parse_players("test/support/fixtures/rushing.json") == {:ok, %{}}
    end
  end

end
