defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    res =
      rna
      |> String.codepoints()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&of_codon/1)
      |> Enum.take_while(&(!match?({:ok, "STOP"}, &1)))

    case Enum.any?(res, &(match?({:error, _}, &1))) do
      true ->
        {:error, "invalid RNA"}

      _ ->
        {:ok, Enum.map(res, fn {:ok, codon} -> codon end)}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """

  @codons """
    UGU -> Cysteine
    UGC -> Cysteine
    UUA -> Leucine
    UUG -> Leucine
    AUG -> Methionine
    UUU -> Phenylalanine
    UUC -> Phenylalanine
    UCU -> Serine
    UCC -> Serine
    UCA -> Serine
    UCG -> Serine
    UGG -> Tryptophan
    UAU -> Tyrosine
    UAC -> Tyrosine
    UAA -> STOP
    UAG -> STOP
    UGA -> STOP
  """
  |> String.trim()
  |> String.split("\n")
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.split(&1, " -> "))
  |> Enum.map(&List.to_tuple/1)
  |> Enum.into(%{})

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codons, codon) do
      {:ok, _} = val
        -> val
      :error ->
        {:error, "invalid codon"}
    end
  end
end
