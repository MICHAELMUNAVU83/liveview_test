defmodule LiveviewTestWeb.NameControllerTest do
  use LiveviewTestWeb.ConnCase

  import LiveviewTest.NamesFixtures

  @create_attrs %{todo: "some todo"}
  @update_attrs %{todo: "some updated todo"}
  @invalid_attrs %{todo: nil}

  describe "index" do
    test "lists all names", %{conn: conn} do
      conn = get(conn, Routes.name_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Names"
    end
  end

  describe "new name" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.name_path(conn, :new))
      assert html_response(conn, 200) =~ "New Name"
    end
  end

  describe "create name" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.name_path(conn, :create), name: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.name_path(conn, :show, id)

      conn = get(conn, Routes.name_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Name"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.name_path(conn, :create), name: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Name"
    end
  end

  describe "edit name" do
    setup [:create_name]

    test "renders form for editing chosen name", %{conn: conn, name: name} do
      conn = get(conn, Routes.name_path(conn, :edit, name))
      assert html_response(conn, 200) =~ "Edit Name"
    end
  end

  describe "update name" do
    setup [:create_name]

    test "redirects when data is valid", %{conn: conn, name: name} do
      conn = put(conn, Routes.name_path(conn, :update, name), name: @update_attrs)
      assert redirected_to(conn) == Routes.name_path(conn, :show, name)

      conn = get(conn, Routes.name_path(conn, :show, name))
      assert html_response(conn, 200) =~ "some updated todo"
    end

    test "renders errors when data is invalid", %{conn: conn, name: name} do
      conn = put(conn, Routes.name_path(conn, :update, name), name: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Name"
    end
  end

  describe "delete name" do
    setup [:create_name]

    test "deletes chosen name", %{conn: conn, name: name} do
      conn = delete(conn, Routes.name_path(conn, :delete, name))
      assert redirected_to(conn) == Routes.name_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.name_path(conn, :show, name))
      end
    end
  end

  defp create_name(_) do
    name = name_fixture()
    %{name: name}
  end
end
