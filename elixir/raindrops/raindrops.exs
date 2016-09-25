defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    text = map_factors(number)
    case String.length(text) do
      0 -> "#{number}"
      _ -> text
    end
  end

  defp map_factors(number) do
    [
      {3, "Pling"},
      {5, "Plang"},
      {7, "Plong"}
    ]
    |> Enum.map(fn {fac, text} ->
      if rem(number, fac) == 0, do: text
    end)
    |> Enum.join()
  end
end
