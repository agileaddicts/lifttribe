defmodule LifttribeWeb.WorkoutController do
  use LifttribeWeb, :controller

  alias Lifttribe.Lifttribe

  def index(conn, _params) do
    athlete = conn.assigns[:athlete]

    workouts = Lifttribe.latest_workouts(athlete)
    render(conn, "index.html", page_title: "Workouts", workouts: workouts)
  end

  def new(conn, _params) do
    athlete = conn.assigns[:athlete]

    workout = Lifttribe.fetch_or_create_todays_workout(athlete)
    render(conn, "new.html", workout: workout)
  end
end
