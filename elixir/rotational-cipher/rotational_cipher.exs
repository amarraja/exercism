defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> do_rotate(shift)
    |> to_string()
  end

  defp do_rotate([], _shift) do
    []
  end

  defp do_rotate([h|t], shift) do
    [translate_character(h, shift) | do_rotate(t, shift)]
  end

  defp translate_character(c, shift) when c >= ?a and c <= ?z do
    shift(c, shift, ?a, ?z)
  end

  defp translate_character(c, shift) when c >= ?A and c <= ?Z do
    shift(c, shift, ?A, ?Z)
  end

  defp translate_character(c, _shift)  do
    c
  end

  defp shift(c, shift, lower, upper) do
    case c + shift do
      shifted when shifted > upper ->
        lower + (shifted - upper - 1)
      shifted ->
        shifted
    end
  end

end
