defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @command_map [
    {0b1, "wink"},
    {0b10, "double blink"},
    {0b100, "close your eyes"},
    {0b1000, "jump"},
    {0b10000, :reverse}
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    Enum.reduce(@command_map, [], fn {flag, command}, acc ->
      case flag &&& code do
        0 ->
          acc
        _ ->
          apply_command(command, acc)
      end
    end)
    |> Enum.reverse()
  end

  defp apply_command(:reverse, acc) do
    Enum.reverse(acc)
  end

  defp apply_command(command, acc) do
    [command | acc]
  end



end
