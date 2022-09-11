defmodule Lifttribe.Set do
  use Ecto.Schema
  import Ecto.Changeset

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
        uuid: Ecto.UUID.generate(),
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
    |> Lifttribe.Repo.insert()
  end

  def change_comment(%Set{} = set, comment) do
    set
    |> cast(%{comment: comment}, [:comment])
    |> Lifttribe.Repo.update()
  end
end
