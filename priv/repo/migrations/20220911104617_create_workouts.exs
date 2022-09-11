defmodule Lifttribe.Repo.Migrations.CreateWorkouts do
  use Ecto.Migration

  def change do
    create table(:workouts) do
      add :uuid, :uuid, null: false
      add :athlete_id, references(:athletes), null: false
      add :date, :date, null: false
      add :comment, :text

      timestamps()
    end

    create(unique_index(:workouts, :uuid, name: :workouts_uuid_index))
    create(unique_index(:workouts, [:athlete_id, :date], name: :workouts_athlete_id_date_index))
  end
end
