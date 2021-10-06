# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, result} = NflRushing.Stats.Parser.parse_players("priv/rushing.json")

# For the inital file with 326 records will not be used, but will be applied with I need to load a larger file.
batch_size = 50

Enum.chunk_every(result, batch_size)
|> Enum.each(fn batch -> NflRushing.Repo.insert_all(NflRushing.Stats.Player, batch) end)
