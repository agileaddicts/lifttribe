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
    case Map.get(params, name, "0") |> Integer.parse() do
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
    [
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Set 1 (65%)",
        weight: get_closest_bar_weight(tm * 0.65),
        reps: 5
      },
      %{
        name: "Set 2 (75%)",
        weight: get_closest_bar_weight(tm * 0.75),
        reps: 5
      },
      %{
        name: "Set 3 (85%)",
        weight: get_closest_bar_weight(tm * 0.85),
        reps: 5
      }
    ]
  end

  defp generate_sets(tm, 2) do
    [
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Warm Up",
        weight: get_closest_bar_weight(tm * 0.5),
        reps: 5
      },
      %{
        name: "Set 1 (70%)",
        weight: get_closest_bar_weight(tm * 0.7),
        reps: 3
      },
      %{
        name: "Set 2 (80%)",
        weight: get_closest_bar_weight(tm * 0.8),
        reps: 3
      },
      %{
        name: "Set 3 (90%)",
        weight: get_closest_bar_weight(tm * 0.9),
        reps: 3
      }
    ]
  end

  defp get_set_name(week, day, set) do
    with day when not is_nil(day) <- Enum.at(week.days, day, nil),
         set when not is_nil(day) <- Enum.at(day.sets, set, nil) do
      set.name
    end
  end

  defp get_set_weight_and_reps(week, day, set) do
    with day when not is_nil(day) <- Enum.at(week.days, day, nil),
         set when not is_nil(day) <- Enum.at(day.sets, set, nil) do
      "#{set.weight} kg x #{set.reps}"
    end
  end
end
