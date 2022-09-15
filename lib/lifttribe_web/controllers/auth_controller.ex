defmodule LifttribeWeb.AuthController do
  use LifttribeWeb, :controller

  def login(conn, _params) do
    render(conn, "login.html", page_title: "Login")
  end
end
