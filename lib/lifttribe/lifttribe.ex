defmodule Lifttribe.Lifttribe do
  @moduledoc false

  import Ecto.Query

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias Lifttribe.Repo
  alias Lifttribe.Workout

  def fetch_or_create_todays_workout(%Athlete{} = athlete) do
    today = Date.utc_today()

    query =
      from(w in Workout, where: w.athlete_id == ^athlete.id and w.date == ^today, preload: [:sets])

    case Repo.one(query) do
      nil ->
        {:ok, workout} = Workout.create(athlete, Date.utc_today())
        workout

      workout ->
        workout
    end
  end

  def fetch_or_create_auth_code(athlete) do
    athlete = athlete |> Repo.preload(:auth_code)

    case athlete.auth_code do
      nil ->
        {:ok, auth_code} = AuthCode.create(athlete)
        auth_code

      auth_code ->
        auth_code
    end
  end

  def latest_workouts(%Athlete{} = athlete) do
    query =
      from(w in Workout,
        where: w.athlete_id == ^athlete.id,
        order_by: [desc: w.date],
        limit: 25,
        preload: [:sets]
      )

    Repo.all(query)
  end
end
