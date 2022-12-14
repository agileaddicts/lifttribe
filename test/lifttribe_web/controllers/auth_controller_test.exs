defmodule LifttribeWeb.AuthControllerTest do
  use LifttribeWeb.ConnCase

  import Lifttribe.Factory
  import Swoosh.TestAssertions

  alias Lifttribe.AuthMailer
  alias Lifttribe.Repo

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

  test "GET /auth/login", %{conn: conn} do
    conn = get(conn, "/auth/login")
    assert html_response(conn, 200) =~ "Login"
  end

  test "POST /auth/send_auth_code with existing email", %{conn: conn} do
    athlete = insert!(:athlete)

    conn = post(conn, "/auth/send_auth_code", email: athlete.email)
    assert redirected_to(conn) == "/"
    assert get_flash(conn, :info)

    athlete_from_db = Repo.preload(athlete, :auth_code)
    assert_email_sent(AuthMailer.login_link_email(conn, athlete, athlete_from_db.auth_code))
  end

  test "POST /auth/send_auth_code with non-existing email", %{conn: conn} do
    conn = post(conn, "/auth/send_auth_code", email: "nonexisting@lifttribe.local")
    assert redirected_to(conn) == "/"
    assert get_flash(conn, :info)
    refute_email_sent()
  end
end
