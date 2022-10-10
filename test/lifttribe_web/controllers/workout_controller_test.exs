defmodule LifttribeWeb.WorkoutControllerTest do
  use LifttribeWeb.ConnCase

  import Lifttribe.Factory

  test "GET /workouts as logged in user", %{conn: conn} do
    athlete = insert!(:athlete)

    conn =
      conn
      |> log_in_athlete(athlete)
      |> get("/workouts")

    assert html_response(conn, 200) =~ "Your Workouts"
  end

  test "GET /workouts without session", %{conn: conn} do
    conn = get(conn, "/workouts")

    assert redirected_to(conn) == Routes.auth_path(conn, :login)
  end
end
