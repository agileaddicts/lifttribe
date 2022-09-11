defmodule Lifttribe.AthleteTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.Athlete

  describe "create/2" do
    test "correct insert with unique username and email" do
      {:ok, athlete} = Athlete.create("test", "test@lifttribe.dev")

      assert athlete.id
      assert athlete.uuid

      athlete_from_db = Lifttribe.Repo.get_by(Athlete, username: "test")
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
end
