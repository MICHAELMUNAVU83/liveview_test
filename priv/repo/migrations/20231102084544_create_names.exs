defmodule LiveviewTest.Repo.Migrations.CreateNames do
  use Ecto.Migration

  def change do
    create table(:names) do
      add :todo, :string

      timestamps()
    end
  end
end
