defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, key), do: :not_found
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(numbers, key, lo, hi) when lo > hi, do: :not_found
  defp search(numbers, key, lo, hi) do
    midpoint = trunc(:math.floor((hi + lo) / 2))
    case elem(numbers, midpoint) do
      ^key ->
        {:ok, midpoint}
      x when x < key ->
        search(numbers, key, midpoint + 1, hi)
      x when x > key ->
        search(numbers, key, lo, midpoint - 1)
      _ ->
        :not_found
    end
  end
end
