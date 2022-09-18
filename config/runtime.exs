import Config

if config_env() == :prod do
  basic_auth_username = System.get_env("BASIC_AUTH_USERNAME") || nil
  basic_auth_password = System.get_env("BASIC_AUTH_PASSWORD") || nil

  base_url =
    System.get_env("BASE_URL") ||
      raise """
      environment variable BASE_URL is missing.
      """

  config :lifttribe,
    basic_auth_username: basic_auth_username,
    basic_auth_password: basic_auth_password,
    base_url: base_url

  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      """

  ecto_ipv6? = System.get_env("ECTO_IPV6") == "true"

  pool_size = String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :lifttribe, Lifttribe.Repo,
    url: database_url,
    socket_options: if(ecto_ipv6?, do: [:inet6], else: []),
    pool_size: pool_size

  http_port = String.to_integer(System.get_env("PORT") || "4000")

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  url_host = System.get_env("PHX_HOST")

  config :lifttribe, LifttribeWeb.Endpoint,
    http: [port: http_port],
    secret_key_base: secret_key_base,
    url: [host: url_host, port: http_port]

  sendgrid_api_key =
    System.get_env("SENDGRID_API_KEY") ||
      raise """
      environment variable SENDGRID_API_KEY is missing.
      """

  config :lifttribe, Lifttribe.Mailer, api_key: sendgrid_api_key
end
