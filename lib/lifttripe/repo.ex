defmodule Lifttripe.Repo do
  use Ecto.Repo,
    otp_app: :lifttripe,
    adapter: Ecto.Adapters.Postgres
end
