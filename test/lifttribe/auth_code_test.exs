defmodule Lifttribe.AuthCodeTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.AuthCode

  describe "create/2" do
    test "correct insert with unique Athlete" do
      athlete = insert!(:athlete)

      {:ok, auth_code} = AuthCode.create(athlete)

      auth_code_from_db = Lifttribe.Repo.get(AuthCode, auth_code.id)
      assert auth_code_from_db
    end

    test "error with duplicated athlete" do
      auth_code = insert!(:auth_code)

      {:error, changeset} = AuthCode.create(auth_code.athlete)

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :athlete end)
    end
  end
end
