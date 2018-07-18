defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(input) do
    input
    |> String.split("\n")
    |> process()
    |> Enum.join()
    |> replace_markdown_tags()
  end

  def process([], acc), do: Enum.reverse(acc)
  defp process(list), do: process(list, [])

  def process(["#" <> _ = line | t], acc), do:
    process(t, [create_header(line) | acc])

  def process(["* " <> _ | _] = list, acc), do:
    process_ul(list, acc, [])

  def process([h | t], acc), do:
    process(t, [wrap_tag(h, "p") | acc])

  def process_ul(["* " <> line | tail], acc, listacc), do:
    process_ul(tail, acc, [line | listacc])

  def process_ul(list, acc, listacc) do
    list_items = Enum.reverse(listacc)
    process(list, [create_ul(list_items) | acc])
  end


  def create_header("#" <> rest, count \\ 0), do: create_header(rest, count + 1)
  def create_header(" " <> rest, count), do: wrap_tag(rest, "h#{count}")

  defp create_ul(items) do
    items
    |> Enum.map(&wrap_tag(&1, "li"))
    |> Enum.join()
    |> wrap_tag("ul")
  end

  defp replace_markdown_tags(body) do
    body
    |> process_markdown_replacement("__", "strong")
    |> process_markdown_replacement("_", "em")
  end

  defp process_markdown_replacement(input, marker, tag) do
    ~r/#{marker}([^#{marker}]+)#{marker}/
    |>  Regex.replace(input, fn _, c -> wrap_tag(c, tag) end)
  end

  defp wrap_tag(contents, tag), do:
    "<#{tag}>#{contents}</#{tag}>"

end
