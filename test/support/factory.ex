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

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
