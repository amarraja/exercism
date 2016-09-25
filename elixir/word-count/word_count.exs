defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    tokenize(sentence)
    |> Enum.reduce(%{}, fn word, map ->
      Map.update(map, word, 1, &(&1 + 1))
    end)
  end

  defp tokenize(sentence) do
    String.split(sentence, " ")
    |> Enum.map(&scrub_word/1)
    |> Enum.map(&split_words/1)
    |> List.flatten()
    |> Enum.map(&(String.downcase(&1)))
    |> Enum.filter(&(String.length(&1) > 0))
  end

  defp scrub_word(w) do
    String.replace(w, ~r/[^\w-_]/, "")
  end

  defp split_words(word) do
    String.split(word, "_")
  end
end
