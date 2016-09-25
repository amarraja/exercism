defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0) do
    raise ArgumentError, message: "n needs to be > 0"
  end
  #TODO: Implement using lazy streams
  def nth(count), do: nth(2, count, 0)
  def nth(from, 0, acc), do: acc
  def nth(from, left, acc) do
    case is_prime?(from) do
      true -> nth(from + 1, left - 1, from)
      false -> nth(from + 1, left, from)
    end
  end

  def is_prime?(1), do: false
  def is_prime?(2), do: true
  def is_prime?(n) do
    !Enum.any?(2..(n - 1), fn fac -> rem(n, fac) == 0 end)
  end

end
