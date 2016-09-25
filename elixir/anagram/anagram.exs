defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    normalised_base = normalise(base)
    candidates
    |> Enum.reject(&(String.downcase(&1) == String.downcase(base)))
    |> Enum.filter(&(normalise(&1) == normalised_base))
  end

  defp normalise(string) do
    string
    |> String.downcase
    |> String.codepoints
    |> Enum.sort
    |> Enum.join
  end

end
