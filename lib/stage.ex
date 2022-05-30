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
  def calc(:launch, mass, planet) do
      fuel = mass * get_gravity(planet) * 0.042 - 33
      floor(fuel) |> trunc()
  end

  def calc(:land, mass, planet) do
    fuel = mass * get_gravity(planet) * 0.033 - 42
    floor(fuel) |> trunc()
  end

  @doc """
    extra_fuel/3
    Calculate fuel requirements for a round trip, including extra fuel for itself.

    ## Examples
    iex> MissionControl.Stage.extra_fuel(:land, 28801, 9.807)
  """
  @spec extra_fuel(atom(), number(), float()) :: integer
  def extra_fuel(stage, mass, planet) when stage == :land or stage == :launch do
    gravity = get_gravity(planet)
    fuel_required = calc(stage, mass, gravity)

    if fuel_required <= 0,
      do: 0,
      else: fuel_required + extra_fuel(stage, fuel_required, gravity)
  end

  @doc """
      get_gravity/1
      Get Planet gravity value.

      ## Examples
      iex> MissionControl.Stage.get_gravity(:earth)
      9.807

      iex> MissionControl.Stage.get_gravity(9.807)
      9.807
  """
  @spec get_gravity(any) :: any
  def get_gravity(key) when is_float(key) or is_map_key(@planets, key) do
    case @planets[key] do
      nil -> key
      gravity -> gravity
    end
  end
end
