defmodule Lifttribe.SetTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.Repo
  alias Lifttribe.Set

  describe "create/5" do
    test "correct insert with unique athlete and date" do
      workout = insert!(:workout)

      {:ok, set} = Set.create(workout, 0, "Test Exercise", 62.5, 5)

      assert set.id
      assert set.uuid

      set_from_db = Repo.get(Set, set.id)

      assert set_from_db
    end

    test "correct insert with same workout and different order_index" do
      set = insert!(:set)

      {:ok, second_set} = Set.create(set.workout, set.order_index + 1, "Test Exercise", 62.5, 5)

      assert second_set.id
      assert second_set.uuid

      set_from_db = Repo.get(Set, second_set.id)

      assert set_from_db
    end

    test "correct insert with different workout and same order_index" do
      set = insert!(:set)

      different_workout =
        insert!(:workout, athlete: set.workout.athlete, date: Date.add(Date.utc_today(), -1))

      {:ok, second_set} = Set.create(different_workout, set.order_index, "Test Exercise", 62.5, 5)

      assert second_set.id
      assert second_set.uuid

      set_from_db = Repo.get(Set, second_set.id)

      assert set_from_db
    end

    test "error with duplicated workout and order_index" do
      set = insert!(:set)

      {:error, changeset} = Set.create(set.workout, set.order_index, "Test Exercise", 62.5, 5)

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :workout end)
    end
  end

  describe "change_comment/2" do
    test "correct update with valid comment" do
      set = insert!(:set)

      {:ok, changed_set} = Set.change_comment(set, "Some random comment")

      assert changed_set.comment
    end
  end
end
