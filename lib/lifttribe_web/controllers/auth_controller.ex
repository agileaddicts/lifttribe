defmodule LifttribeWeb.AuthController do
  use LifttribeWeb, :controller

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias Lifttribe.Repo

  def authenticate(conn, %{
        "athlete_uuid" => athlete_uuid,
        "auth_code_uuid" => auth_code_uuid
      }) do
    with %Athlete{} = athlete <- find_athlete(athlete_uuid),
         true <- athlete.auth_code.uuid == auth_code_uuid,
         true <- AuthCode.invalidate(athlete.auth_code) do
      conn
      |> put_session(:athlete_uuid, athlete.uuid)
      |> configure_session(renew: true)
      |> redirect(to: "/workouts")
    else
      _else ->
        conn
        |> put_flash(:error, "Login not possible!")
        |> redirect(to: "/")
    end
  end

  defp find_athlete(athlete_uuid) do
    athlete_uuid
    |> Athlete.find_by_uuid()
    |> Repo.preload(:auth_code)
  end

  def direct_login(conn, %{"email" => email}) do
    case Athlete.find_by_email(email) do
      nil ->
        conn
        |> put_flash(:error, "Login not possible!")
        |> redirect(to: "/")

      athlete ->
        conn
        |> put_session(:athlete_uuid, athlete.uuid)
        |> configure_session(renew: true)
        |> redirect(to: "/workouts")
    end
  end
end
