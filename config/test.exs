import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :lifttribe, Lifttribe.Repo,
  username: "postgres",
  password: "postgres",
  database: "lifttribe_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lifttribe, LifttribeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "lmXMhslC+/fDA/f+M7qhE0yp8ol/A1Jz8uOyYkqTDgYPdTonLPBVmcKCkjfM2/Ck",
  server: false

# In test we don't send emails.
config :lifttribe, Lifttribe.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
