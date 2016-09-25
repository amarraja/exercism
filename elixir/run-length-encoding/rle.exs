defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints()
    |> Enum.chunk_by(&(&1))
    |> Enum.map(fn arr ->
      "#{Enum.count(arr)}#{hd(arr)}"
    end)
    |> Enum.join()
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> do_decode([])
    |> Enum.join()
  end

  defp do_decode("", acc) do
    Enum.reverse(acc)
  end

  defp do_decode(string, acc) do
    { times, rest } = Integer.parse(string)
    { char, remainder } = String.split_at(rest, 1)
    str = String.duplicate(char, times)
    do_decode(remainder, [str | acc])
  end


end
