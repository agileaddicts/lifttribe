defmodule Lifttribe.Repo do
  use Ecto.Repo,
    otp_app: :lifttribe,
    adapter: Ecto.Adapters.Postgres
end
