defmodule TwelveDays do

  @lines [
    "a Partridge in a Pear Tree",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

  @counts ~w(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    lyrics =
      @lines
      |> Enum.take(number)
      |> Enum.reverse()
      |> build_verse("")

    count = Enum.at(@counts, number - 1)
    "On the #{count} day of Christmas my true love gave to me, #{lyrics}."
  end

  defp build_verse([h], "" = acc), do: build_verse([], acc <> h)
  defp build_verse([h], acc), do: build_verse([], acc <> "and " <> h)
  defp build_verse([h | t], acc), do: build_verse(t, [acc <> h <> ", "])
  defp build_verse([], acc), do: acc


  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
