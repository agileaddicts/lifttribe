defmodule Lifttribe.Lifttribe do
  import Ecto.Query

  alias Lifttribe.Athlete
  alias Lifttribe.Repo
  alias Lifttribe.Workout

  def latest_workouts(%Athlete{} = athlete) do
    query =
      from(w in Workout, where: w.athlete_id == ^athlete.id, order_by: [desc: w.date], limit: 25, preload: [:sets])

    Repo.all(query)
  end
end
