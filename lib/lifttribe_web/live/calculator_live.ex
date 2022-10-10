defmodule LifttribeWeb.CalculatorLive do
  use LifttribeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       numbers: %{
         squat: %{
           max: 0,
           tm: 0
         },
         bench: %{
           max: 0,
           tm: 0
         },
         deadlift: %{
           max: 0,
           tm: 0
         },
         ohp: %{
           max: 0,
           tm: 0
         }
       },
       plan: %{
         name: "5/3/1 Original 4 Days",
         weeks: []
       }
     )}
  end

  def handle_event("save", params, socket) do
    numbers = %{
      squat: extract_numbers(params, "squat"),
      bench: extract_numbers(params, "bench"),
      deadlift: extract_numbers(params, "deadlift"),
      ohp: extract_numbers(params, "ohp")
    }

    plan = %{
      name: "5/3/1 Original 4 Days",
      weeks: [
        %{
          name: "Week 1",
          days: [
            %{
              name: "Day 1",
              exercise: "Squat",
              sets: generate_sets(numbers.squat.tm, 1)
            },
            %{
              name: "Day 2",
              exercise: "Bench",
              sets: generate_sets(numbers.bench.tm, 1)
            },
            %{
              name: "Day 3",
              exercise: "Deadlift",
              sets: generate_sets(numbers.deadlift.tm, 1)
            },
            %{
              name: "Day 4",
              exercise: "Overhead Press",
              sets: generate_sets(numbers.ohp.tm, 1)
            }
          ]
        },
        %{
          name: "Week 2",
          days: [
            %{
              name: "Day 1",
              exercise: "Squat",
              sets: generate_sets(numbers.squat.tm, 2)
            },
            %{
              name: "Day 2",
              exercise: "Bench",
              sets: generate_sets(numbers.bench.tm, 2)
            },
            %{
              name: "Day 3",
              exercise: "Deadlift",
              sets: generate_sets(numbers.deadlift.tm, 2)
            },
            %{
              name: "Day 4",
              exercise: "Overhead Press",
              sets: generate_sets(numbers.ohp.tm, 2)
            }
          ]
        }
      ]
    }

    {:noreply,
     assign(socket,
       numbers: numbers,
       plan: plan
     )}
  end

  defp extract_numbers(params, name) do
    max = extract_exercise_pr(params, name)

    %{
      max: max,
      tm: get_closest_bar_weight(max * 0.95)
    }
  end

  defp extract_exercise_pr(params, name) do
    case params |> Map.get(name, "0") |> Integer.parse() do
      {num, ""} -> num
      _else -> 0
    end
  end

  defp get_closest_bar_weight(0.0), do: 0
  defp get_closest_bar_weight(tm) when tm <= 20, do: 20

  defp get_closest_bar_weight(tm) do
    lower_bound = Float.floor(tm / 2.5) * 2.5
    upper_bound = Float.ceil(tm / 2.5) * 2.5

    case tm - lower_bound < upper_bound - tm do
      true -> lower_bound
      false -> upper_bound
    end
  end

  defp generate_sets(tm, 1) do
    Enum.map(
      [
        {"Warm Up", 0.5, 5},
        {"Warm Up", 0.5, 5},
        {"Warm Up", 0.5, 5},
        {"Set 1 (65%)", 0.65, 5},
        {"Set 2 (75%)", 0.75, 5},
        {"Set 3 (85%)", 0.85, 5}
      ],
      fn {name, multiplier, reps} ->
        generate_set(name, tm, multiplier, reps)
      end
    )
  end

  defp generate_sets(tm, 2) do
    Enum.map(
      [
        {"Warm Up", 0.5, 5},
        {"Warm Up", 0.5, 5},
        {"Warm Up", 0.5, 5},
        {"Set 1 (70%)", 0.7, 3},
        {"Set 2 (80%)", 0.8, 3},
        {"Set 3 (90%)", 0.9, 3}
      ],
      fn {name, multiplier, reps} ->
        generate_set(name, tm, multiplier, reps)
      end
    )
  end

  defp generate_set(name, tm, multiplier, reps) do
    %{
      name: name,
      weight: get_closest_bar_weight(tm * multiplier),
      reps: reps
    }
  end

  defp get_set_name(week, day_int, set) do
    with day when not is_map(day) <- Enum.at(week.days, day_int, nil),
         set when not is_map(set) <- Enum.at(day.sets, set, nil) do
      set.name
    end
  end

  defp get_set_weight_and_reps(week, day_int, set) do
    with day when not is_map(day) <- Enum.at(week.days, day_int, nil),
         set when not is_map(set) <- Enum.at(day.sets, set, nil) do
      "#{set.weight} kg x #{set.reps}"
    end
  end
end
