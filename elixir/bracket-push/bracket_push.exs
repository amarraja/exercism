defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    String.codepoints(str)
    |> Enum.reduce([], &process_char/2)
    |> Enum.empty?
  end

  def process_char("{" = c, state), do: [c | state]
  def process_char("(" = c, state), do: [c | state]
  def process_char("[" = c, state), do: [c | state]
  def process_char("}", ["{" | tl]), do: tl
  def process_char("}", [h | tl]), do: ["Unexpected #{h}" | tl]
  def process_char(")", ["(" | tl]), do: tl
  def process_char(")", [h | tl]), do: ["Unexpected #{h}" | tl]
  def process_char("]", ["[" | tl]), do: tl
  def process_char("]", [h | tl]), do: ["Unexpected #{h}" | tl]
  def process_char(_, state), do: state

end
