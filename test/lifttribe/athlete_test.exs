defmodule Lifttribe.AthleteTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.Athlete

  describe "create/2" do
    test "correct insert with unique username and email" do
      {:ok, athlete} = Athlete.create("test", "test@lifttribe.dev")

      assert athlete.id
      assert athlete.uuid

      athlete_from_db = Lifttribe.Repo.get(Athlete, athlete.id)
      assert athlete_from_db
    end

    test "error with duplicated username" do
      insert!(:athlete, username: "test")

      {:error, changeset} = Athlete.create("test", "test@lifttribe.dev")

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :username end)
    end

    test "error with duplicated email" do
      insert!(:athlete, email: "test@lifttribe.dev")

      {:error, changeset} = Athlete.create("test", "test@lifttribe.dev")

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :email end)
    end
  end

  describe "find_by_uuid/1" do
    test "returns correct athlete" do
      athlete = insert!(:athlete)

      assert Athlete.find_by_uuid(athlete.uuid)
    end

    test "returns nil with non-existing athlete" do
      refute Athlete.find_by_uuid(Ecto.UUID.generate())
    end
  end
end
