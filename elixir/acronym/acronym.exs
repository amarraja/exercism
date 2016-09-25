defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(" ")
    |> Enum.map(&extract_capitals/1)
    |> Enum.join()
  end

  defp extract_capitals(string) do
    [h|t] = String.codepoints(string)
    caps = Enum.filter(t, &(&1 =~ ~r/[A-Z]/))
    [String.upcase(h) | caps]
    |> Enum.join()
  end

end
