defmodule LifttribeWeb.AuthControllerTest do
  use LifttribeWeb.ConnCase

  test "GET /auth/login", %{conn: conn} do
    conn = get(conn, "/auth/login")
    assert html_response(conn, 200) =~ "Login"
  end
end
