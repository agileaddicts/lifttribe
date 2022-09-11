defmodule Lifttribe.Factory do
  alias Lifttribe.Repo

  # Factories

  def build(:athlete) do
    %Lifttribe.Athlete{
      uuid: Ecto.UUID.generate(),
      username: Faker.Internet.user_name(),
      email: Faker.Internet.email()
    }
  end

  def build(:workout) do
    %Lifttribe.Workout{
      uuid: Ecto.UUID.generate(),
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
