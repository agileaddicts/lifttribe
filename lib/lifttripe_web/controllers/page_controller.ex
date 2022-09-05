defmodule LifttripeWeb.PageController do
  use LifttripeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
