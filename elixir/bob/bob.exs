defmodule Bob do
  def hey(input) do
    cond do
        all_empty?(input) -> "Fine. Be that way!"
        question?(input) -> "Sure."
        shouting?(input) -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end

  defp all_empty?(input) do
    String.strip(input) == ""
  end

  defp shouting?(string) do
    string == String.upcase(string)
  end

  defp question?(string) do
    String.last(string) == "?"
  end

end
