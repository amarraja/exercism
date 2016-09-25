defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @earth_period 31557600
  @orbital_periods %{
    earth: @earth_period,
    mercury: @earth_period * 0.2408467,
    venus: @earth_period * 0.61519726,
    mars: @earth_period * 1.8808158,
    jupiter: @earth_period * 11.862615,
    saturn: @earth_period * 29.447498,
    uranus: @earth_period * 84.016846,
    neptune: @earth_period * 164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    orbital_period = @orbital_periods[planet]
    seconds / orbital_period
  end
end
