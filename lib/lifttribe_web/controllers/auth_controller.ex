defmodule LifttribeWeb.AuthController do
  use LifttribeWeb, :controller

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias Lifttribe.AuthMailer
  alias Lifttribe.Lifttribe, as: LT
  alias Lifttribe.Mailer
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
      |> redirect(to: Routes.workout_path(conn, :index))
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
        |> redirect(to: Routes.workout_path(conn, :index))
    end
  end

  def login(conn, _params) do
    render(conn, "login.html", page_title: "Login")
  end

  def send_auth_code(conn, %{"email" => email}) do
    case Athlete.find_by_email(email) do
      # do nothing
      nil ->
        nil

      athlete ->
        auth_code = LT.fetch_or_create_auth_code(athlete)
        conn |> AuthMailer.login_link_email(athlete, auth_code) |> Mailer.deliver()
    end

    conn
    |> put_flash(:info, "We have sent you the login link to your email")
    |> redirect(to: "/")
  end
end
