defmodule LifttribeWeb.PageController do
  use LifttribeWeb, :controller

  def five_three_one(conn, _params) do
    render(conn, "five_three_one.html", page_title: "5/3/1")
  end

  def index(conn, _params) do
    conn
    # |> put_flash(:error, "Test text")
    |> render("index.html", page_title: "Home")
  end

  def love(conn, _params) do
    render(conn, "love.html", page_title: "♡")
  end
end
