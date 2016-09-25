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
    is_prime = is_prime?(from)
    next = if is_prime, do: left-1, else: left
    nth(from + 1, next, from)
  end

  def is_prime?(1), do: false
  def is_prime?(2), do: true
  def is_prime?(n) do
    !Enum.any?(2..(n - 1), fn fac -> rem(n, fac) == 0 end)
  end

end
