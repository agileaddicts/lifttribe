defmodule Lifttribe.AuthCodeTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.AuthCode

  describe "create/2" do
    test "correct insert with unique Athlete" do
      athlete = insert!(:athlete)

      {:ok, auth_code} = AuthCode.create(athlete)

      assert Lifttribe.Repo.get(AuthCode, auth_code.id)
    end

    test "error with duplicated athlete" do
      auth_code = insert!(:auth_code)

      {:error, changeset} = AuthCode.create(auth_code.athlete)

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :athlete end)
    end
  end

  describe "invalidate/1" do
    test "deletes auth_code from database" do
      auth_code = insert!(:auth_code)

      assert AuthCode.invalidate(auth_code)
      refute AuthCode.find_by_uuid(auth_code.uuid)
    end

    test "fails with auth_code not yet persisted" do
      auth_code = build(:auth_code)

      refute AuthCode.invalidate(auth_code)
    end
  end

  describe "find_by_uuid/1" do
    test "returns correct auth_code" do
      auth_code = insert!(:auth_code)

      assert AuthCode.find_by_uuid(auth_code.uuid)
    end

    test "returns nil with non-existing auth_code" do
      refute AuthCode.find_by_uuid(Ecto.UUID.generate())
    end
  end
end
