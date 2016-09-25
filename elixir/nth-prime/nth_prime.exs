defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0) do
    raise ArgumentError, message: "n needs to be > 0"
  end
  #TODO: Implement using lazy streams
  def nth(count) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&is_prime?/1)
    |> Enum.take(count)
    |> Enum.to_list
    |> List.last
  end
  
  def is_prime?(1), do: false
  def is_prime?(2), do: true
  def is_prime?(n) do
    !Enum.any?(2..(n - 1), fn fac -> rem(n, fac) == 0 end)
  end

end
