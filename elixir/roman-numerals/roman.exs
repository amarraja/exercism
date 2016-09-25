defmodule Roman do

  @glyphmap %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M",
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    do_numerals(number, "")
  end

  def do_numerals(0, acc), do: acc
  def do_numerals(number, acc) do
    b = biggest_matching(number)
    acc = acc <> @glyphmap[b]
    do_numerals(number - b, acc)
  end

  defp biggest_matching(number) do
    Map.keys(@glyphmap)
    |> Enum.filter(fn k -> k <= number end)
    |> Enum.reverse
    |> hd
  end

end
