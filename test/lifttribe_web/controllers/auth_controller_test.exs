defmodule LifttribeWeb.AuthControllerTest do
  use LifttribeWeb.ConnCase

  import Lifttribe.Factory

  test "GET /auth/login", %{conn: conn} do
    conn = get(conn, "/auth/login")
    assert html_response(conn, 200) =~ "Login"
  end

  test "POST /auth/send_auth_code with existing email", %{conn: conn} do
    athlete = insert!(:athlete)

    conn = post(conn, "/auth/send_auth_code", email: athlete.email)
    assert redirected_to(conn) == Routes.page_path(conn, :index)
    assert get_flash(conn, :info)
  end

  test "POST /auth/send_auth_code with non-existing email", %{conn: conn} do
    conn = post(conn, "/auth/send_auth_code", email: "nonexisting@lifttribe.local")
    assert redirected_to(conn) == Routes.page_path(conn, :index)
    assert get_flash(conn, :info)
  end
end
