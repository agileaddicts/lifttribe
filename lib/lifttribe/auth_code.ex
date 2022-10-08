defmodule Lifttribe.AuthCode do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.NoPrimaryKeyValueError
  alias Ecto.UUID
  alias Lifttribe.Athlete
  alias Lifttribe.AuthCode
  alias Lifttribe.Repo

  schema "auth_codes" do
    field :uuid, :binary_id

    belongs_to :athlete, Athlete

    timestamps()
  end

  def create(%Athlete{} = athlete) do
    %AuthCode{}
    |> cast(
      %{
        uuid: UUID.generate()
      },
      [:uuid]
    )
    |> validate_required([:uuid])
    |> unique_constraint(:athlete, name: :auth_codes_athlete_id_index)
    |> put_assoc(:athlete, athlete)
    |> Repo.insert()
  end

  def invalidate(%AuthCode{} = auth_code) do
    case Repo.delete(auth_code) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  rescue
    NoPrimaryKeyValueError -> false
  end

  def find_by_uuid(uuid) do
    Repo.get_by(AuthCode, uuid: uuid)
    |> Repo.preload(:athlete)
  end
end
