defmodule Lifttribe.Athlete do
  use Ecto.Schema
  import Ecto.Changeset

  alias Lifttribe.Athlete
  alias Lifttribe.Workout

  schema "athletes" do
    field :uuid, :binary_id
    field :username, :string
    field :email, :string

    has_many :workouts, Workout

    timestamps()
  end

  def create(username, email) do
    %Athlete{}
    |> cast(
      %{
        uuid: Ecto.UUID.generate(),
        username: username,
        email: email
      },
      [:uuid, :username, :email]
    )
    |> validate_required([:uuid, :username, :email])
    |> unique_constraint(:username, name: :athletes_username_index)
    |> unique_constraint(:email, name: :athletes_email_index)
    |> Lifttribe.Repo.insert()
  end
end
