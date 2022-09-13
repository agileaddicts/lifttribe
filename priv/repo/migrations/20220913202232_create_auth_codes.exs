defmodule Lifttribe.Repo.Migrations.CreateAuthCodes do
  use Ecto.Migration

  def change do
    create table(:auth_codes) do
      add :uuid, :uuid, null: false
      add :athlete_id, references(:athletes), null: false

      timestamps()
    end

    create(unique_index(:auth_codes, :uuid, name: :auth_codes_uuid_index))
    create(unique_index(:auth_codes, :athlete_id, name: :auth_codes_athlete_id_index))
  end
end
