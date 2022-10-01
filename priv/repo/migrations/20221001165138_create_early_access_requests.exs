defmodule Lifttribe.Repo.Migrations.CreateEarlyAccessRequests do
  use Ecto.Migration

  def change do
    create table(:early_access_requests) do
      add :uuid, :uuid, null: false
      add :email, :string, null: false

      timestamps()
    end

    create(unique_index(:early_access_requests, :uuid, name: :early_access_requests_uuid_index))
    create(unique_index(:early_access_requests, :email, name: :early_access_requests_email_index))
  end
end
