defmodule Lifttribe.Workout do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.UUID
  alias Lifttribe.Athlete
  alias Lifttribe.Repo
  alias Lifttribe.Set
  alias Lifttribe.Workout

  schema "workouts" do
    field :uuid, :binary_id
    field :date, :date
    field :comment, :string

    belongs_to :athlete, Athlete

    timestamps()

    has_many :sets, Set
  end

  def create(%Athlete{} = athlete, date) do
    %Workout{}
    |> cast(
      %{
        uuid: UUID.generate(),
        date: date
      },
      [:uuid, :date]
    )
    |> validate_required([:uuid, :date])
    |> put_assoc(:athlete, athlete)
    |> unique_constraint(
      [:athlete, :date],
      name: :workouts_athlete_id_date_index
    )
    |> Repo.insert()
  end

  def change_comment(%Workout{} = workout, comment) do
    workout
    |> cast(%{comment: comment}, [:comment])
    |> Repo.update()
  end
end
