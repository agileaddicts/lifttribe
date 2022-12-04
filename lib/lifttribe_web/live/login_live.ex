defmodule LifttribeWeb.LoginLive do
  use Phoenix.LiveView

  alias Lifttribe.Athlete
  alias Lifttribe.AuthMailer
  alias Lifttribe.Lifttribe, as: LT
  alias Lifttribe.Mailer

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("send_auth_code", %{"email" => email}, socket) do
    case Athlete.find_by_email(email) do
      # do nothing
      nil ->
        nil

      athlete ->
        auth_code = LT.fetch_or_create_auth_code(athlete)
        socket |> AuthMailer.login_link_email(athlete, auth_code) |> Mailer.deliver()
    end

    socket = put_flash(socket, :info, "We have sent you the login link to your email")

    {:noreply, push_navigate(socket, to: "/")}
  end
end
