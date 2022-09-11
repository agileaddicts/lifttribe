defmodule Lifttribe.Repo.Migrations.CreateSets do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :uuid, :uuid, null: false
      add :workout_id, references(:workouts), null: false
      add :order_index, :integer, null: false
      add :exercise, :string, null: false
      add :weight, :float, null: false
      add :reps, :integer, null: false
      add :comment, :text

      timestamps()
    end

    create(unique_index(:sets, :uuid, name: :sets_uuid_index))

    create(
      unique_index(:sets, [:workout_id, :order_index], name: :sets_workout_id_order_index_index)
    )
  end
end
