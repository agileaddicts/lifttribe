defmodule Lifttribe.Repo.Migrations.CreateAthletes do
  use Ecto.Migration

  def change do
    create table(:athletes) do
      add :uuid, :uuid, null: false
      add :username, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create(unique_index(:athletes, :uuid, name: :athletes_uuid_index))
    create(unique_index(:athletes, :username, name: :athletes_username_index))
    create(unique_index(:athletes, :email, name: :athletes_email_index))
  end
end
