defmodule LiveviewTest.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveviewTest.Blogs` context.
  """

  @doc """
  Generate a blog.
  """
  def blog_fixture(attrs \\ %{}) do
    {:ok, blog} =
      attrs
      |> Enum.into(%{
        name: "some name",
        author: "some author"
      })
      |> LiveviewTest.Blogs.create_blog()

    blog
  end
end
