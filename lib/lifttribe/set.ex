defmodule Lifttribe.Set do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.UUID
  alias Lifttribe.Repo
  alias Lifttribe.Set
  alias Lifttribe.Workout

  schema "sets" do
    field :uuid, :binary_id
    field :order_index, :integer
    field :exercise, :string
    field :weight, :float
    field :reps, :integer
    field :comment, :string

    belongs_to :workout, Workout

    timestamps()
  end

  def create(%Workout{} = workout, order_index, exercise, weight, reps) do
    %Set{}
    |> cast(
      %{
        uuid: UUID.generate(),
        order_index: order_index,
        exercise: exercise,
        weight: weight,
        reps: reps
      },
      [:uuid, :order_index, :exercise, :weight, :reps]
    )
    |> validate_required([:uuid, :order_index, :exercise, :weight, :reps])
    |> put_assoc(:workout, workout)
    |> unique_constraint(
      [:workout, :order_index],
      name: :sets_workout_id_order_index_index
    )
    |> Repo.insert()
  end

  def change_comment(%Set{} = set, comment) do
    set
    |> cast(%{comment: comment}, [:comment])
    |> Repo.update()
  end
end
