defmodule MissionControl.Stage do
  @planets %{earth: 9.807, moon: 1.62, mars: 3.711}

  @moduledoc """
    Documentation for `Stage`.
  """

  @doc """
    calc/3

    Calculate basic fuel requirements for Mission Stages: Launch and Land
    launch: mass * gravity * 0.042 - 33
    land: mass * gravity * 0.033 - 42

    ## Examples
    iex> MissionControl.Stage.calc(:land, 28801, 9.807)
    9278
  """
  @spec calc(atom(), number(), number()) :: integer
  def calc(stage, mass, gravity) do
      stage_type = set_stage_type(stage)
      planet_gravity = get_gravity(gravity)
      fuel = mass * planet_gravity * stage_type.coefficient - stage_type.constant
      floor(fuel) |> trunc()
  end

  @doc """
    extra_fuel/3
    Calculate fuel requirements for a round trip, including extra fuel for itself.

    ## Examples
    iex> MissionControl.Stage.extra_fuel(:land, 28801, 9.807)
  """
  @spec extra_fuel(atom(), number(), float()) :: integer
  def extra_fuel(stage, mass, gravity) do
    planet_gravity = get_gravity(gravity)
    fuel_required = calc(stage, mass, planet_gravity)


    if fuel_required <= 0,
      do: 0,
      else: fuel_required + extra_fuel(stage, fuel_required, planet_gravity)
  end

  @doc """
      get_gravity/1
      Get gravity value via keyword.

      ## Examples
      iex> MissionControl.Stage.get_gravity(:earth)
      9.807

      iex> MissionControl.Stage.get_gravity(9.807)
      9.807
  """
  @spec get_gravity(any) :: any
  def get_gravity(key) do
    case @planets[key] do
      nil -> key
      gravity -> gravity
    end
  end

  defp set_stage_type(:launch), do: %{coefficient: 0.042, constant: 33}
  defp set_stage_type(:land),   do: %{coefficient: 0.033, constant: 42}
  defp set_stage_type(_),       do: %{coefficient: 0, constant: 0}
end
