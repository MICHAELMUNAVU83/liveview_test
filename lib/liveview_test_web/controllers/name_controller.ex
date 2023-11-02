defmodule LiveviewTestWeb.NameController do
  use LiveviewTestWeb, :controller

  alias LiveviewTest.Names
  alias LiveviewTest.Names.Name

  def index(conn, _params) do
    names = Names.list_names()
    render(conn, "index.html", names: names)
  end

  def new(conn, _params) do
    changeset = Names.change_name(%Name{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"name" => name_params}) do
    case Names.create_name(name_params) do
      {:ok, name} ->
        conn
        |> put_flash(:info, "Name created successfully.")
        |> redirect(to: Routes.name_path(conn, :show, name))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    name = Names.get_name!(id)
    render(conn, "show.html", name: name)
  end

  def edit(conn, %{"id" => id}) do
    name = Names.get_name!(id)
    changeset = Names.change_name(name)
    render(conn, "edit.html", name: name, changeset: changeset)
  end

  def update(conn, %{"id" => id, "name" => name_params}) do
    name = Names.get_name!(id)

    case Names.update_name(name, name_params) do
      {:ok, name} ->
        conn
        |> put_flash(:info, "Name updated successfully.")
        |> redirect(to: Routes.name_path(conn, :show, name))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", name: name, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    name = Names.get_name!(id)
    {:ok, _name} = Names.delete_name(name)

    conn
    |> put_flash(:info, "Name deleted successfully.")
    |> redirect(to: Routes.name_path(conn, :index))
  end
end
