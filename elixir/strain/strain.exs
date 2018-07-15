defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    strain(list, fn i -> fun.(i) end)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    strain(list, fn i -> !fun.(i) end)
  end

  defp strain(list, check_fun) do
    list
    |> Enum.reduce([], fn i, acc ->
      cond do
        check_fun.(i) ->
          [i | acc]
        true ->
          acc
      end
    end)
    |> Enum.reverse()
  end

end
