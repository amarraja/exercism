defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode("") do
    ""
  end
  
  def encode(str) do
    input = clean_text(str)
    cols = square_size(input)

    input
    |> String.codepoints()
    |> Enum.chunk_every(cols)
    |> Enum.map(&fill_list(&1, cols))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join(&1, ""))
    |> Enum.map(&String.trim/1)
    |> Enum.join(" ")
  end

  def fill_list(list, count) do
    list_count = Enum.count(list)
    if list_count == count do
      list
    else
      remainder = count - list_count
      list ++ List.duplicate(" ", remainder)
    end
  end

  def square_size(input) do
    count = input |> String.codepoints() |> Enum.count
    cols = :math.sqrt(count) |> :math.ceil |> to_string()
    { int, _rest } = Integer.parse(cols)
    int
  end

  def clean_text(input) do
    input = String.downcase(input)
    Regex.replace(~r/[^a-z0-9]/, input, "")
  end
end
