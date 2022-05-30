defmodule MissionControl.ValidationTest do
  use ExUnit.Case
  doctest MissionControl.Validation

  test "should fail with invalid Mission Stages and return error status" do
    {status, _message} = MissionControl.Validation.check(28_801, "fake")

    assert status == :error
  end

  test "should fail with invalid Mission Stages and return error message" do
    {_status, message} = MissionControl.Validation.check(28_801, "fake")

    assert message == "Invalid Mission Stages."
  end

  test "should fail with invalid Mission Stages and return data type error" do
    response = {:error, "Ship weight must be an integer."}

    assert response == MissionControl.Validation.check(1.23, [{:land, :earth}])
  end

  test "should fail with invalid Mission Stages and return weight size error" do
    response = {:error, "Ship weight must be greather then 0."}

    assert response == MissionControl.Validation.check(-1, [{:land, :earth}])
  end

  test "should fail with empty list Mission Stage" do
    response = {:error, "Invalid Mission Stages."}

    assert response == MissionControl.Validation.check(28_801, [])
  end

  test "should fail with empty tuple Mission Stage" do
    response = {:error, "Invalid Mission Stages."}

    assert response == MissionControl.Validation.check(28_801, [{}])
  end

  test "should fail with invalid Single Mission Stage" do
    response = {:error, "Invalid Mission Stage."}

    assert response == MissionControl.Validation.check_single(:laun)
  end

  test "should return valid Mission Stage" do
    response = {:ok, [land: :earth]}
    stage = [{:land, :earth}]

    assert response == MissionControl.Validation.check(28_801, stage)
  end

  test "should return Mission Stage" do
    response = {:ok, :launch}

    assert response == MissionControl.Validation.check_single(:launch)
  end
end
