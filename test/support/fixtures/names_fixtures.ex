defmodule LiveviewTest.NamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveviewTest.Names` context.
  """

  @doc """
  Generate a name.
  """
  def name_fixture(attrs \\ %{}) do
    {:ok, name} =
      attrs
      |> Enum.into(%{
        todo: "some todo"
      })
      |> LiveviewTest.Names.create_name()

    name
  end
end
