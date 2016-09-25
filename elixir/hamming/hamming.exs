defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    case length(strand1) == length(strand2) do
      true -> { :ok, ham(strand1, strand2) }
      _ -> { :error, "Lists must be the same length" }
    end
  end

  defp ham(strand1, strand2) do
    Enum.zip(strand1, strand2)
    |> Enum.filter(fn {a, b} -> a != b end)
    |> Enum.count
  end

end
