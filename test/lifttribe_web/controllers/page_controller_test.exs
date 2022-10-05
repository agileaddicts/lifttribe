defmodule LifttribeWeb.PageControllerTest do
  use LifttribeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome"
  end

  test "GET /531", %{conn: conn} do
    conn = get(conn, "/531")
    assert html_response(conn, 200) =~ "5/3/1 Calculator"
  end

  test "GET /love", %{conn: conn} do
    conn = get(conn, "/love")
    assert html_response(conn, 200) =~ "Love is Love"
  end
end
