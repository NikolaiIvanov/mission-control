defmodule MissionControl.StageTest do
  use ExUnit.Case
  doctest MissionControl.Stage

  test "should return calculated result for the Apollo 11 Land Mission Stage" do
    # Apollo 11 Command and Service Module weight of 28801 kg
    # launch: mass * gravity * 0.042 - 33
    # Earth gravity: 9.807 m/s2
    # 28801 * 9.807 * 0.033 - 42 = 9278
    fuel_for_land_on_earth = 9278

    assert MissionControl.Stage.calc(:land, 28_801, 9.807)  == fuel_for_land_on_earth
    assert MissionControl.Stage.calc(:land, 28_801, :earth) == fuel_for_land_on_earth
  end

  test "should return calculated result of extra fuel for the Apollo 11 Land Mission Stage" do
    # Fuel for land on Earth = 9278
    # 9278 fuel requires 2960 more fuel
    # 2960 fuel requires 915 more fuel
    # 915 fuel requires 254 more fuel
    # 254 fuel requires 40 more fuel
    # 40 fuel requires no more fuel
    #
    # Extra fuel for itself = 4169
    # Total fuel is: 9278 + 4169 = 13447
    total_fuel_for_land_on_earth = 13_447

    assert MissionControl.Stage.extra_fuel(:land, 28_801, 9.807)  == total_fuel_for_land_on_earth
    assert MissionControl.Stage.extra_fuel(:land, 28_801, :earth)  == total_fuel_for_land_on_earth
  end

  test "should return Planet Gravity" do
    earth = 9.807
    moon  = 1.62
    mars  = 3.711

    assert MissionControl.Stage.get_gravity(:earth) == earth
    assert MissionControl.Stage.get_gravity(earth)  == earth

    assert MissionControl.Stage.get_gravity(:moon) == moon
    assert MissionControl.Stage.get_gravity(moon)  == moon

    assert MissionControl.Stage.get_gravity(:mars) == mars
    assert MissionControl.Stage.get_gravity(mars)  == mars
  end
end
