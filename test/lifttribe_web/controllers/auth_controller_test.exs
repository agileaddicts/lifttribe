defmodule LifttribeWeb.AuthControllerTest do
  use LifttribeWeb.ConnCase

  import Lifttribe.Factory

  test "GET /auth/authenticate_athlete/:athlete_uuid with correct params", %{conn: conn} do
    auth_code = insert!(:auth_code)

    conn =
      get(conn, "/auth/authenticate_athlete/#{auth_code.athlete.uuid}",
        auth_code_uuid: auth_code.uuid
      )

    assert redirected_to(conn) == "/workouts"
  end

  test "GET /auth/authenticate_athlete/:athlete_uuid with incorrect auth_code_id params", %{
    conn: conn
  } do
    auth_code = insert!(:auth_code)

    conn =
      get(conn, "/auth/authenticate_athlete/#{auth_code.athlete.uuid}", auth_code_uuid: "wrong")

    assert redirected_to(conn) == "/"
    assert get_flash(conn, :error)
  end

  test "GET /auth/authenticate_athlete/:athlete_uuid with non-existing athlete_uuid", %{
    conn: conn
  } do
    auth_code = insert!(:auth_code)

    conn = get(conn, "/auth/authenticate_athlete/wrong", auth_code_uuid: auth_code.uuid)

    assert redirected_to(conn) == "/"
    assert get_flash(conn, :error)
  end

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "Sign in to your account"
  end

  @tag :skip
  test "POST /auth/send_auth_code with existing email" do
  end

  @tag :sip
  test "POST /auth/send_auth_code with non-existing email" do
  end
end
