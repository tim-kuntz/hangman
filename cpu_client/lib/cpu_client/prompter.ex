defmodule CpuClient.Prompter do

  alias TextClient.State

  def accept_move(game = %State{tally: tally}) do
    tally.letters
    |> letter_distribution()
    |> next_guess(tally.used)
    |> update_game(game)
  end

  defp letter_distribution(letters) do
    letters
    |> filtered_word_list
    |> Enum.join("")
    |> String.codepoints
    |> Enum.reduce(%{}, fn(letter, acc) ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
    |> Map.to_list
    |> List.keysort(1)
    |> Enum.map(&(elem(&1,0)))
    |> Enum.reverse
  end

  defp filtered_word_list(letters) do
    {:ok, matcher} = matcher(["^" | letters] ++ ["$"])
    Dictionary.word_list()
    |> Enum.filter(fn(word) -> word =~ matcher end)
  end

  defp matcher(letters) do
    letters
    |> Enum.join("")
    |> String.replace("_", ".")
    |> Regex.compile()
  end

  defp next_guess(list = [h | t], used) do
    next_unused_letter(list, used, Enum.member?(used, h))
  end

  defp next_unused_letter([_|t], used, _in_use = true) do
    next_guess(t, used)
  end

  defp next_unused_letter([h|_], _used, _) do
    h |> IO.inspect
  end

  def update_game(input, game = %State{}) do
    Map.put(game, :guess, input)
  end

end

