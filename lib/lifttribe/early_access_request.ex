defmodule Lifttribe.EarlyAccessRequest do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.UUID
  alias Lifttribe.EarlyAccessRequest
  alias Lifttribe.Repo

  schema "early_access_requests" do
    field :uuid, :binary_id
    field :email, :string

    timestamps()
  end

  def create(email) do
    %EarlyAccessRequest{}
    |> cast(
      %{
        uuid: UUID.generate(),
        email: email
      },
      [:uuid, :email]
    )
    |> validate_required([:uuid, :email])
    |> unique_constraint(:email, name: :early_access_requests_email_index)
    |> Repo.insert()
  end
end
