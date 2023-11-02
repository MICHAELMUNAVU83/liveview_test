defmodule LiveviewTest.NamesTest do
  use LiveviewTest.DataCase

  alias LiveviewTest.Names

  describe "names" do
    alias LiveviewTest.Names.Name

    import LiveviewTest.NamesFixtures

    @invalid_attrs %{todo: nil}

    test "list_names/0 returns all names" do
      name = name_fixture()
      assert Names.list_names() == [name]
    end

    test "get_name!/1 returns the name with given id" do
      name = name_fixture()
      assert Names.get_name!(name.id) == name
    end

    test "create_name/1 with valid data creates a name" do
      valid_attrs = %{todo: "some todo"}

      assert {:ok, %Name{} = name} = Names.create_name(valid_attrs)
      assert name.todo == "some todo"
    end

    test "create_name/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Names.create_name(@invalid_attrs)
    end

    test "update_name/2 with valid data updates the name" do
      name = name_fixture()
      update_attrs = %{todo: "some updated todo"}

      assert {:ok, %Name{} = name} = Names.update_name(name, update_attrs)
      assert name.todo == "some updated todo"
    end

    test "update_name/2 with invalid data returns error changeset" do
      name = name_fixture()
      assert {:error, %Ecto.Changeset{}} = Names.update_name(name, @invalid_attrs)
      assert name == Names.get_name!(name.id)
    end

    test "delete_name/1 deletes the name" do
      name = name_fixture()
      assert {:ok, %Name{}} = Names.delete_name(name)
      assert_raise Ecto.NoResultsError, fn -> Names.get_name!(name.id) end
    end

    test "change_name/1 returns a name changeset" do
      name = name_fixture()
      assert %Ecto.Changeset{} = Names.change_name(name)
    end
  end
end
