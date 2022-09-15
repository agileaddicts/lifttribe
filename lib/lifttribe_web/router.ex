defmodule LifttribeWeb.Router do
  use LifttribeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LifttribeWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :basic_auth do
    plug :auth
  end

  scope "/", LifttribeWeb do
    pipe_through [:browser, :basic_auth]

    get "/", PageController, :index
    get "/531", PageController, :five_three_one
    get "/love", PageController, :love

    get "/auth/login", AuthController, :login
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

  defp auth(conn, _opts) do
    case Application.get_env(:lifttribe, :basic_auth_username) do
      nil ->
        conn

      username ->
        password = Application.fetch_env!(:lifttribe, :basic_auth_password)
        Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end
end
