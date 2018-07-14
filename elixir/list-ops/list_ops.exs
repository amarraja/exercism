defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp count([h|t], acc) do
    count(t, acc + 1)
  end

  defp count([], acc) do
    acc
  end

  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([h|t], acc) do
    reverse(t, [h | acc])
  end

  defp reverse([], acc) do
    acc
  end

  @spec map(list, (any -> any)) :: list
  def map([h|t], f) do
    [f.(h) | map(t, f)]
  end

  def map([], _f) do
    []
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([h|t], f) do
    if f.(h) do
      [ h | filter(t, f) ]
    else
      filter(t, f)
    end
  end

  def filter([], _f) do
    []
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([h|t], acc, f) do
    acc = f.(h, acc)
    reduce(t, acc, f)
  end

  def reduce([], acc, _f) do
    acc
  end

  @spec append(list, list) :: list
  def append([h|t], b) do
    [h | append(t, b)]
  end

  def append([], b) do
    b
  end

  @spec concat([[any]]) :: [any]
  def concat([h|t]) when is_list(h) do
    append(concat(h), concat(t))
  end

  def concat([h|t]) do
    [h | concat(t)]
  end

  def concat([]) do
    []
  end



end
