defmodule MissionControlTest do
  use ExUnit.Case
  doctest MissionControl

  test "should return help chapters" do
    help_chapters = [:examples, :methods, :requirenments]

    assert %{examples: _} = MissionControl.help()
    assert Map.keys(MissionControl.help) == help_chapters
  end

  test "should fail with invalid planet gravity for single Mission Stage" do
    {status, _message} = MissionControl.calculate(28_801, :land, 9)

    assert status == :error
  end

  test "should return calculated result for single Mission Stage" do
    # arguments: 28801, :launch, 9.807
    expected_result = 13_447

    assert MissionControl.calculate(28_801, :land, 9.807) == expected_result
    assert MissionControl.calculate(28_801, :land, :earth) == expected_result
  end

  test "should return calculated result for Apollo 11 Mission" do
    # Apollo 11 Mission
    # path: launch Earth, land Moon, launch Moon, land Earth
    # weight of equipment: 28801 kg
    # weight of fuel: 51898 kg
    # arguments: 28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]

    start_weight = 28_801
    expected_result = 51_898
    mission_path = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 9.807}
    ]

    assert MissionControl.calculate(start_weight, mission_path) == expected_result
  end

  test "should return calculated fuel result for Mission on Mars" do
    # Mission on Mars
    # path: launch Earth, land Mars, launch Mars, land Earth
    # weight of equipment: 14606 kg
    # weight of fuel: 33388 kg
    # arguments: 14606, [[:launch, 9.807], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]

    start_weight = 14_606
    expected_result = 33_388
    mission_path = [
      {:launch, :earth},
      {:land, :mars},
      {:launch, :mars},
      {:land, :earth}
    ]

    assert MissionControl.calculate(start_weight, mission_path) == expected_result
  end

  test "should return calculated fuel result for Passenger ship Mission" do
    # Passenger ship Mission
    # path: launch Earth, land Moon, launch Moon, land Mars, launch Mars, land Earth
    # weight of equipment: 75432 kg
    # weight of fuel: 212161 kg
    # arguments: 75432, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 3.711], [:launch, 3.711], [:land, 9.807]]

    start_weight = 75_432
    expected_result = 212_161
    mission_path = [
      {:launch, 9.807},
      {:land, 1.62},
      {:launch, 1.62},
      {:land, 3.711},
      {:launch, 3.711},
      {:land, 9.807}
    ]

    assert MissionControl.calculate(start_weight, mission_path) == expected_result
  end
end
