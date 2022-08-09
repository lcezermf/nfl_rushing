defmodule NflRushing.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NflRushing.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> NflRushing.Groups.create_group()

    group
  end
end
