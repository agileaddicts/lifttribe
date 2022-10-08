defmodule Lifttribe.EarlyAccessRequestTest do
  use Lifttribe.DataCase, async: true

  import Lifttribe.Factory

  alias Lifttribe.EarlyAccessRequest
  alias Lifttribe.Repo

  describe "create/2" do
    test "correct insert with unique username and email" do
      {:ok, early_access_request} = EarlyAccessRequest.create("test@lifttribe.dev")

      assert early_access_request.id
      assert early_access_request.uuid

      early_access_request_from_db =
        Repo.get(EarlyAccessRequest, early_access_request.id)

      assert early_access_request_from_db
    end

    test "error with duplicated email" do
      insert!(:early_access_request, email: "test@lifttribe.dev")

      {:error, changeset} = EarlyAccessRequest.create("test@lifttribe.dev")

      refute changeset.valid?
      assert length(changeset.errors) == 1
      assert Enum.any?(changeset.errors, fn {field, _error} -> field == :email end)
    end
  end
end
