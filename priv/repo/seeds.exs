# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lifttribe.Repo.insert!(%Lifttribe.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, athlete_1} = Lifttribe.Athlete.create("Number1", "number1@lifttribe.local")

{:ok, workout_1} = Lifttribe.Workout.create(athlete_1, Date.utc_today())

{:ok, _set_1} = Lifttribe.Set.create(workout_1, 0, "Squat", 20, 10)
{:ok, _set_2} = Lifttribe.Set.create(workout_1, 1, "Squat", 40, 5)
{:ok, _set_3} = Lifttribe.Set.create(workout_1, 2, "Squat", 50, 5)
{:ok, _set_4} = Lifttribe.Set.create(workout_1, 3, "Squat", 60, 5)
{:ok, _set_5} = Lifttribe.Set.create(workout_1, 4, "Squat", 65, 5)
{:ok, _set_6} = Lifttribe.Set.create(workout_1, 5, "Squat", 70, 5)
