defmodule Lifttribe.AuthMailer do
  import Swoosh.Email

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias LifttribeWeb.Router.Helpers, as: Routes

  def send_login_link(conn, %Athlete{} = athlete, %AuthCode{} = auth_code) do
    new()
    |> to({athlete.username, athlete.email})
    |> from({"Lifttribe", "hello@lifttribe.dev"})
    |> subject("Your login link")
    |> text_body(
      "Hello #{athlete.username},\n\nUse this link to log in: #{Routes.auth_url(conn, :authenticate, athlete.uuid, auth_code_uuid: auth_code.uuid)}\n\nHave fun at the gym,\nSebastian"
    )
  end
end
