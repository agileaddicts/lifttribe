# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :lifttribe,
  ecto_repos: [Lifttribe.Repo],
  basic_auth_username: nil,
  basic_auth_password: nil,
  base_url: "http://localhost:4000"

# Configures the endpoint
config :lifttribe, LifttribeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: LifttribeWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lifttribe.PubSub,
  live_view: [signing_salt: "4/B5l4ve"]

config :lifttribe, Lifttribe.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
