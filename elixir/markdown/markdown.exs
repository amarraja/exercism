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

  defp process(list) do
    process(list, [])
  end

  defp process([], acc) do
    Enum.reverse(acc)
  end

  defp process(["#" <> _ = line | rest], acc) do
    [prefix | content] = String.split(line)
    header_tag = "h#{String.length(prefix)}"
    content = Enum.join(content, " ")
    header = wrap_in_tag(content, header_tag)
    process(rest, [header | acc])
  end

  defp process(["*" <> _ | _] = lines, acc) do
    {li, rest} =
      lines
      |> Enum.split_while(&String.starts_with?(&1, "*"))

    ul =
      li
      |> Enum.map(&String.trim_leading(&1, "* "))
      |> Enum.map(&wrap_in_tag(&1, "li"))
      |> Enum.join()
      |> wrap_in_tag("ul")

    process(rest, [ul | acc])
  end

  defp process([line | rest], acc) do
    paragraph = wrap_in_tag(line, "p")
    process(rest, [paragraph | acc])
  end

  defp replace_markdown_tags(body) do
    body
    |> process_markdown_replacement("__", "strong")
    |> process_markdown_replacement("_", "em")
  end

  defp process_markdown_replacement(input, marker, tag) do
    ~r/#{marker}([^#{marker}]+)#{marker}/
    |>  Regex.replace(input, fn _, c -> wrap_in_tag(c, tag) end)
  end

  defp wrap_in_tag(contents, tag) do
    open_tag = "<#{tag}>"
    close_tag = "</#{tag}>"
    "#{open_tag}#{contents}#{close_tag}"
  end

end
