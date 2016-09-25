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

  defp is_sub_list?(_, []) do
    false
  end

  defp is_sub_list?(a, b) do
    if (same_heads(a, b)) do
      true
    else
       is_sub_list?(a, tl(b))
    end
  end

  defp same_heads([], _), do: true
  defp same_heads([h | t1], [h | t2]), do: same_heads(t1, t2)
  defp same_heads(_, _), do: false


end
