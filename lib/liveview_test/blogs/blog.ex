defmodule LiveviewTest.Blogs.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :name, :string
    field :author, :string

    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:name, :author])
    |> validate_required([:name, :author])
  end
end
