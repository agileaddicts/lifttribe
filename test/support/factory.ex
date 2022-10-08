defmodule Lifttribe.Factory do
  @moduledoc false

  alias Ecto.UUID
  alias Faker.Internet
  alias Faker.Lorem
  alias Lifttribe.Repo

  # Factories

  def build(:athlete) do
    %Lifttribe.Athlete{
      uuid: UUID.generate(),
      username: Internet.user_name(),
      email: Internet.email()
    }
  end

  def build(:auth_code) do
    %Lifttribe.AuthCode{
      uuid: UUID.generate(),
      athlete: build(:athlete)
    }
  end

  def build(:early_access_request) do
    %Lifttribe.EarlyAccessRequest{
      uuid: UUID.generate(),
      email: Internet.email()
    }
  end

  def build(:set) do
    %Lifttribe.Set{
      uuid: UUID.generate(),
      workout: build(:workout),
      order_index: 0,
      exercise: Lorem.word(),
      weight: 50.0,
      reps: 5
    }
  end

  def build(:workout) do
    %Lifttribe.Workout{
      uuid: UUID.generate(),
      athlete: build(:athlete),
      date: Date.utc_today()
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
