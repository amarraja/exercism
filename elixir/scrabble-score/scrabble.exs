defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    String.upcase(word)
    |> to_char_list
    |> Enum.map(&letter_score/1)
    |> Enum.sum
  end

  defp letter_score(l) when l in 'AEIOULNRST', do: 1
  defp letter_score(l) when l in 'DG', do: 2
  defp letter_score(l) when l in 'BCMP', do: 3
  defp letter_score(l) when l in 'FHVWY', do: 4
  defp letter_score(l) when l in 'K', do: 5
  defp letter_score(l) when l in 'JX', do: 8
  defp letter_score(l) when l in 'QZ', do: 10
  defp letter_score(_), do: 0
  
end
