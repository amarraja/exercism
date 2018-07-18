defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    reduce(l, 0, fn _, acc -> acc + 1 end)
  end

  def reverse(l) do
    reduce(l, [], fn el, acc -> [el | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> reduce([], fn el, acc -> [f.(el) | acc] end)
    |> reverse()
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    reduce(l, [], fn el, acc ->
      if f.(el) do
        [el | acc]
      else
        acc
      end
    end)
    |> reverse()
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
  def append(l, b) do
    reverse(l)
    |> reduce(b, fn el, acc -> [el | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(l) do
    reverse(l)
    |> reduce([], fn el, acc -> append(el, acc) end)
  end


end
