defmodule Lifttribe.AuthCode do
  use Ecto.Schema
  import Ecto.Changeset

  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode

  schema "auth_codes" do
    field :uuid, :binary_id

    belongs_to :athlete, Athlete

    timestamps()
  end

  def create(%Athlete{} = athlete) do
    %AuthCode{}
    |> cast(
      %{
        uuid: Ecto.UUID.generate()
      },
      [:uuid]
    )
    |> validate_required([:uuid])
    |> unique_constraint(:athlete, name: :auth_codes_athlete_id_index)
    |> put_assoc(:athlete, athlete)
    |> Lifttribe.Repo.insert()
  end

  def invalidate(%AuthCode{} = auth_code) do
    case Lifttribe.Repo.delete(auth_code) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  rescue
    Ecto.NoPrimaryKeyValueError -> false
  end

  def find_by_uuid(uuid) do
    Lifttribe.Repo.get_by(AuthCode, uuid: uuid)
    |> Lifttribe.Repo.preload(:athlete)
  end
end
