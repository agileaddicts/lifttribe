defmodule Lifttribe.WorkoutTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.Repo
  alias Lifttribe.Workout

  describe "create/2" do
    test "correct insert with unique athlete and date" do
      athlete = insert!(:athlete)

      {:ok, workout} = Workout.create(athlete, Date.utc_today())

      assert workout.id
      assert workout.uuid

      workout_from_db = Repo.get(Workout, workout.id)

      assert workout_from_db
    end

    test "correct insert with same athlete and different date" do
      workout = insert!(:workout)

      {:ok, second_workout} = Workout.create(workout.athlete, Date.add(Date.utc_today(), -1))

      assert second_workout.id
      assert second_workout.uuid

      workout_from_db = Repo.get(Workout, second_workout.id)

      assert workout_from_db
    end

    test "correct insert with different athlete and same date" do
      workout = insert!(:workout)
      different_athlete = insert!(:athlete)

      {:ok, second_workout} = Workout.create(different_athlete, workout.date)

      assert second_workout.id
      assert second_workout.uuid

      workout_from_db = Repo.get(Workout, second_workout.id)

      assert workout_from_db
    end

    test "error with duplicated athlete and date" do
      workout = insert!(:workout)

      {:error, changeset} = Workout.create(workout.athlete, workout.date)

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :athlete end)
    end
  end

  describe "change_comment/2" do
    test "correct update with valid comment" do
      workout = insert!(:workout)

      {:ok, workout} = Workout.change_comment(workout, "Some random comment")

      assert workout.comment
    end
  end
end
