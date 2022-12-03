defmodule LifttribeWeb.WorkoutIndexLive do
  use Phoenix.LiveView

  alias Lifttribe.Athlete
  alias Lifttribe.Lifttribe

  def mount(_params, session, socket) do
    athlete =
      case session["athlete_uuid"] do
        nil -> nil
        athlete_uuid -> Athlete.find_by_uuid(athlete_uuid)
      end

    workouts = Lifttribe.latest_workouts(athlete)

    socket = assign(socket, athlete: athlete, workouts: workouts)

    {:ok, socket}
  end
end
