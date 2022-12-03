# credo:disable-for-this-file Credo.Check.Refactor.ModuleDependencies
defmodule LifttribeWeb.Router do
  @moduledoc false

  use LifttribeWeb, :router

  alias Lifttribe.Athlete
  alias LifttribeWeb.Router.Helpers, as: Routes
  alias Plug.BasicAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LifttribeWeb.LayoutView, :root}
    plug :protect_from_forgery

    plug :put_secure_browser_headers, %{
      "content-security-policy" =>
        "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'; font-src 'self' data:;"
    }

    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :basic_auth do
    plug :auth
  end

  scope "/", LifttribeWeb do
    pipe_through [:browser, :basic_auth]

    live "/", HomeLive
    live "/love", LoveLive

    get "/auth/authenticate_athlete/:athlete_uuid", AuthController, :authenticate

    if Mix.env() == :dev do
      get "/auth/direct_login", AuthController, :direct_login
    end

    get "/auth/login", AuthController, :login
    post "/auth/send_auth_code", AuthController, :send_auth_code
  end

  scope "/workouts", LifttribeWeb do
    pipe_through [:browser, :only_allow_athletes]

    live "/", WorkoutIndexLive
    live "/create", WorkoutCreateLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", LifttribeWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LifttribeWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  defp fetch_user(conn, _opts) do
    athlete_uuid = get_session(conn, :athlete_uuid)

    athlete =
      cond do
        assigned = conn.assigns[:athlete] -> assigned
        athlete_uuid == nil -> nil
        true -> Athlete.find_by_uuid(athlete_uuid)
      end

    assign(conn, :athlete, athlete)
  end

  defp auth(conn, _opts) do
    case Application.get_env(:lifttribe, :basic_auth_username) do
      nil ->
        conn

      username ->
        password = Application.fetch_env!(:lifttribe, :basic_auth_password)
        BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end

  defp only_allow_athletes(conn, _opts) do
    case conn.assigns[:athlete] do
      nil ->
        conn
        |> put_flash(:error, "You must log in to access this page.")
        |> redirect(to: Routes.auth_path(conn, :login))
        |> halt()

      %Athlete{} ->
        conn
    end
  end
end
