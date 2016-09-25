defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1) do
    """
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    on_wall = number - 1
    next = number - 2
    """
#{bottles(on_wall)} of beer on the wall, #{bottles(on_wall)} of beer.
Take #{it(on_wall)} down and pass it around, #{bottles(next)} of beer on the wall.
    """
  end

  defp it(1), do: "it"
  defp it(n), do: "one"
  defp bottles(0), do: "no more bottles"
  defp bottles(1 = n), do: "#{n} bottle"
  defp bottles(n), do: "#{n} bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1) do
    range |> Enum.map(fn v -> "#{verse(v)}" end) |> Enum.join("\n")
  end
end
