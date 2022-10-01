defmodule Lifttribe.EarlyAccessRequest do
  use Ecto.Schema
  import Ecto.Changeset

  alias Lifttribe.EarlyAccessRequest

  schema "early_access_requests" do
    field :uuid, :binary_id
    field :email, :string

    timestamps()
  end

  def create(email) do
    %EarlyAccessRequest{}
    |> cast(
      %{
        uuid: Ecto.UUID.generate(),
        email: email
      },
      [:uuid, :email]
    )
    |> validate_required([:uuid, :email])
    |> unique_constraint(:email, name: :early_access_requests_email_index)
    |> Lifttribe.Repo.insert()
  end
end
