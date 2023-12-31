defmodule LiveviewTestWeb.BlogLiveTest do
  use LiveviewTestWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveviewTest.BlogsFixtures

  @create_attrs %{name: "some name", author: "some author"}
  @update_attrs %{name: "some updated name", author: "some updated author"}
  @invalid_attrs %{name: nil, author: nil}

  defp create_blog(_) do
    blog = blog_fixture()
    %{blog: blog}
  end

  describe "Index" do
    setup [:create_blog]

    test "lists all blogs", %{conn: conn, blog: blog} do
      {:ok, _index_live, html} = live(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Get Started"
      assert html =~ blog.name
    end

    test "saves new blog", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("a", "New Blogs") |> render_click() =~
               "Name"

      assert_patch(index_live, Routes.blog_index_path(conn, :new))

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#blog-form", blog: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Blog created successfully"
      assert html =~ "some name"
    end

    test "updates blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("#blog-#{blog.id} a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(index_live, Routes.blog_index_path(conn, :edit, blog))

      assert index_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#blog-form", blog: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_index_path(conn, :index))

      assert html =~ "Blog updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes blog in listing", %{conn: conn, blog: blog} do
      {:ok, index_live, _html} = live(conn, Routes.blog_index_path(conn, :index))

      assert index_live |> element("#blog-#{blog.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#blog-#{blog.id}")
    end
  end

  describe "Show" do
    setup [:create_blog]

    test "displays blog", %{conn: conn, blog: blog} do
      {:ok, _show_live, html} = live(conn, Routes.blog_show_path(conn, :show, blog))

      assert html =~ "Show Blog"
      assert html =~ blog.name
    end

    test "updates blog within modal", %{conn: conn, blog: blog} do
      {:ok, show_live, _html} = live(conn, Routes.blog_show_path(conn, :show, blog))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Blog"

      assert_patch(show_live, Routes.blog_show_path(conn, :edit, blog))

      assert show_live
             |> form("#blog-form", blog: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#blog-form", blog: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.blog_show_path(conn, :show, blog))

      assert html =~ "Blog updated successfully"
      assert html =~ "some updated name"
    end
  end
end
