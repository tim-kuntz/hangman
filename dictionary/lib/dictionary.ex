defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  # def even_length?([]), do: true
  # def even_length?([_, _ | t]), do: even_length?(t)
  # def even_length?([_ | _]), do: false

end
