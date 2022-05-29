defmodule MissionControl.Validation do
  @stages [:land, :launch]
  @planets [:earth, :moon, :mars]

  @moduledoc """
  Documentation for `Validation`.
  """

  @doc """
    check/2

    Check the Mission Stage is valid?

    ## Examples
    iex> MissionControl.Validation.check(28801, "fake")
    {:error, "Invalid Mission Stages."}

    iex> MissionControl.Validation.check(1.23, [{:land, :earth}])
    {:error, "Ship weight must be an integer."}

    iex> MissionControl.Validation.check(28801, [{:land, :earth}])
    {:ok, [{:land, :earth}]}
  """

  @spec check(integer, list(tuple)) :: tuple
  def check(mass, _stages) when not is_integer(mass), do: {:error, "Ship weight must be an integer."}
  def check(mass, _stages) when is_integer(mass) and mass < 0, do: {:error, "Ship weight must be greather then 0."}
  def check(_mass, stages) do
    case stages do
      stages when is_list(stages) ->
        if  Enum.all?(stages, fn stage ->
              is_tuple(stage) &&
              validate_stages(stage) &&
              validate_gravity(stage)
            end),
           do: {:ok, stages},
           else: {:error, "Invalid Mission Stages."}

      _stages ->
        {:error, "Invalid Mission Stages."}
    end
  end

  @spec check_single(atom) :: {:error, <<_::184>>} | {:ok, atom}
  def check_single(stage) do
    if validate_stage(stage) do
      {:ok, stage}
    else
      {:error, "Invalid Mission Stage."}
    end
  end

  defp validate_stages({stage, _gravity}), do: Enum.member?(@stages, stage)
  defp validate_gravity({_stage, gravity}), do: is_float(gravity) || Enum.member?(@planets, gravity)
  defp validate_stage(stage) when is_atom(stage), do: Enum.member?(@stages, stage)
end
