defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a == b -> :equal
      is_sub_list?(a, b) -> :sublist
      is_sub_list?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp is_sub_list?(a, b) do
    is_sub_list?(a, b, a, b)
  end

  defp is_sub_list?([], _, _a, _b), do: true

  defp is_sub_list?([h|ta], [h|tb], a, b) do
    is_sub_list?(ta, tb, a, b)
  end

  defp is_sub_list?([_|_], [_|_], a, b) do
    is_sub_list?(a, tl(b))
  end

  defp is_sub_list?(_, _, _a, _b), do: false

end
