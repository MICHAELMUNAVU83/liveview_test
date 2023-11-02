defmodule LiveviewTestWeb.PageController do
  use LiveviewTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
