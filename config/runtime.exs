import Config

if config_env() == :prod do
  basic_auth_username = System.get_env("BASIC_AUTH_USERNAME") || nil
  basic_auth_password = System.get_env("BASIC_AUTH_PASSWORD") || nil

  config :lifttripe,
    basic_auth_username: basic_auth_username,
    basic_auth_password: basic_auth_password

  database_url = System.get_env("DATABASE_URL")
  #   raise """
  #   environment variable DATABASE_URL is missing.
  #   For example: ecto://USER:PASS@HOST/DATABASE
  #   """
  pool_size = String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :lifttripe, Lifttripe.Repo,
    # ssl: true,
    # socket_options: [:inet6],
    url: database_url,
    pool_size: pool_size

  http_port = String.to_integer(System.get_env("PORT") || "4000")

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  url_host = System.get_env("PHX_HOST")

  config :lifttripe, LifttripeWeb.Endpoint,
    http: [port: http_port],
    secret_key_base: secret_key_base,
    url: [host: url_host, port: http_port]

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :lifttripe, Lifttripe.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
