defmodule Lifttribe.AuthMailer do
  import Swoosh.Email

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias LifttribeWeb.Router.Helpers, as: Routes

  def login_link_email(conn, %Athlete{} = athlete, %AuthCode{} = auth_code) do
    new()
    |> to({athlete.username, athlete.email})
    |> from({"Lifttribe", "hello@lifttribe.dev"})
    |> subject("Your login link")
    |> text_body(
      "Hello #{athlete.username},\n\nUse this link to log in: #{build_url(Routes.auth_path(conn, :authenticate, athlete.uuid, auth_code_uuid: auth_code.uuid))}\n\nHave fun at the gym,\nSebastian"
    )
  end

  defp build_url(path) do
    base_url = Application.fetch_env!(:lifttribe, :base_url)
    base_url <> path
  end
end
