defmodule LifttribeWeb.WorkoutCreateLive do
  use Phoenix.LiveView

  alias Lifttribe.Athlete
  alias Lifttribe.Lifttribe

  def mount(_params, session, socket) do
    athlete =
      case session["athlete_uuid"] do
        nil -> nil
        athlete_uuid -> Athlete.find_by_uuid(athlete_uuid)
      end

    workout = Lifttribe.fetch_or_create_todays_workout(athlete)

    socket = assign(socket, athlete: athlete, workout: workout)

    {:ok, socket}
  end
end
