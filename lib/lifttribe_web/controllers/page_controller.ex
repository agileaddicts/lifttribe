defmodule LifttribeWeb.PageController do
  use LifttribeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", page_title: "Home")
  end
end
