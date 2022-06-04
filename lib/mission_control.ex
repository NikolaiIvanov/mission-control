defmodule MissionControl do
  import MissionControl.Stage
  import MissionControl.Validation

  @moduledoc """
  Documentation for `MissionControl`.
  MissionControl calculate fuel required for the flight: launch from one planet
  of the Solar system, and to land on another planet of the Solar system,
  depending on the flight route.
  """
  @moduledoc since: "0.1.0"

  @doc """
  MissionControl.help()

  Returns help for the module.

  ## Examples

      iex> MissionControl.help()
      %{
        methods: [
          mission: "MissionControl.calculate(integer, list(tuple))",
          mission_stage: "MissionControl.calculate(integer(), atom(), float())"
        ],
        requirenments: [
          weight: [
            type: "Integer. Example: 28801",
            limitations: "Greather than 0"
          ],
          mission_stages: [
            type: "Keyword List[Atom, Float | Atom], Example: [{:launch, 9.807}, {:land, 1.62}]",
          ],
          planets_available: [
            earth: 9.807,
            moon: 1.62,
            mars: 3.711
          ]
        ],
        examples: [
          mission: "MissionControl.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, :moon}, {:land, :earth}])",
          mission_stage: "MissionControl.calculate(28801, :land, 9.807) or MissionControl.calculate(28801, :land, :earth)"
        ]
      }

  """
  @spec help :: %{
    examples: [{:mission, <<_::808>>} | {:mission_stage, <<_::760>>}, ...],
    methods: [{:mission, <<_::368>>} | {:mission_stage, <<_::416>>}, ...],
    requirenments: [
      {:mission_stages, [...]} | {:planets_available, [...]} | {:weight, [...]},
      ...
    ]
  }
  def help do
    %{
      methods: [
        mission: "MissionControl.calculate(integer, list(tuple))",
        mission_stage: "MissionControl.calculate(integer(), atom(), float())"
      ],
      requirenments: [
        weight: [
          type: "Integer. Example: 28801",
          limitations: "Greather than 0"
        ],
        mission_stages: [
          type: "Keyword List[Atom, Float | Atom], Example: [{:launch, 9.807}, {:land, 1.62}]"
        ],
        planets_available: [
          earth: 9.807,
          moon: 1.62,
          mars: 3.711
        ]
      ],
      examples: [
        mission: "MissionControl.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, :moon}, {:land, :earth}])",
        mission_stage: "MissionControl.calculate(28801, :land, 9.807) or MissionControl.calculate(28801, :land, :earth)"
      ]
    }
  end

  @doc """
  MissionControl.calculate/2

  Calculate fuel required for whole Mission: Launch and Land on each Planet in list

  ## Examples

      iex> MissionControl.calculate(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
      51898

  """
  @spec calculate(
    non_neg_integer(),
    list(tuple())
  ) :: Integer.t() | String.t()
  def calculate(mass, stages) do
    check(mass, stages)
    |> consumption(mass)
  end

  @doc """
  MissionControl.calculate/3

  Calculate fuel required to perform single Stage of Mission: Launch or Land

  ## Examples

      iex>  MissionControl.calculate(28801, :land, 9.807)
      13447

      iex>  MissionControl.calculate(28801, :land, :earth)
      13447

  """
  @spec calculate(
    non_neg_integer(),
    atom(),
    float()
  ) :: Integer.t() | String.t()
  def calculate(mass, stage, planet) do
    check(mass, [{stage, planet}])
    |> consumption(mass)
  end

  @spec consumption(
    tuple(),
    non_neg_integer()
  ) :: Integer.t() | String.t()
  defp consumption({:error, message}, _mass), do: {:error, message <> " Get help: MissionControl.help()"}
  defp consumption({:ok, []}, _mass), do: 0
  defp consumption({:ok, stages}, mass) do
    [current_stage | next_stage] = stages
                 {stage, planet} = current_stage
                         gravity = get_gravity(planet)

    equipment_weight = consumption({:ok, next_stage}, mass)
    equipment_weight + extra_fuel(stage, mass + equipment_weight, gravity)
  end
end
