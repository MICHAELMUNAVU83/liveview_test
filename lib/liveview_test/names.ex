defmodule LiveviewTest.Names do
  @moduledoc """
  The Names context.
  """

  import Ecto.Query, warn: false
  alias LiveviewTest.Repo

  alias LiveviewTest.Names.Name

  @doc """
  Returns the list of names.

  ## Examples

      iex> list_names()
      [%Name{}, ...]

  """
  def list_names do
    Repo.all(Name)
  end

  @doc """
  Gets a single name.

  Raises `Ecto.NoResultsError` if the Name does not exist.

  ## Examples

      iex> get_name!(123)
      %Name{}

      iex> get_name!(456)
      ** (Ecto.NoResultsError)

  """
  def get_name!(id), do: Repo.get!(Name, id)

  @doc """
  Creates a name.

  ## Examples

      iex> create_name(%{field: value})
      {:ok, %Name{}}

      iex> create_name(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_name(attrs \\ %{}) do
    %Name{}
    |> Name.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a name.

  ## Examples

      iex> update_name(name, %{field: new_value})
      {:ok, %Name{}}

      iex> update_name(name, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_name(%Name{} = name, attrs) do
    name
    |> Name.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a name.

  ## Examples

      iex> delete_name(name)
      {:ok, %Name{}}

      iex> delete_name(name)
      {:error, %Ecto.Changeset{}}

  """
  def delete_name(%Name{} = name) do
    Repo.delete(name)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking name changes.

  ## Examples

      iex> change_name(name)
      %Ecto.Changeset{data: %Name{}}

  """
  def change_name(%Name{} = name, attrs \\ %{}) do
    Name.changeset(name, attrs)
  end
end
