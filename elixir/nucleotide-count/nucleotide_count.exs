defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    if !Enum.member?(@nucleotides, nucleotide) do
      raise ArgumentError, message: "#{nucleotide} is not valid"
    end

    invalid = Enum.reject(strand, &(Enum.member?(@nucleotides, &1)))

    if Enum.count(invalid) > 0 do
      raise ArgumentError, message: "Strand has invalid chars:#{invalid}"
    end

    Enum.count(strand, &(&1 == nucleotide))
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    for nucleotide <- @nucleotides, into: %{} do
      { nucleotide, count(strand, nucleotide) }
    end
  end
end
