defmodule LifttribeWeb.PageControllerTest do
  use LifttribeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome"
  end

  test "GET /love", %{conn: conn} do
    conn = get(conn, "/love")
    assert html_response(conn, 200) =~ "Love is Love"
  end
end
