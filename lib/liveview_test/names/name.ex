defmodule LiveviewTest.Names.Name do
  use Ecto.Schema
  import Ecto.Changeset

  schema "names" do
    field :todo, :string

    timestamps()
  end

  @doc false
  def changeset(name, attrs) do
    name
    |> cast(attrs, [:todo])
    |> validate_required([:todo])
  end
end
