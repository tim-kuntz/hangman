defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  import Gallows.Views.Helpers.GameStateHelper

  def new_game_button(conn) do
    button("New Game", to: hangman_path(conn, :create_game))
  end

  def game_over?(%{game_state: game_state}) do
    game_state in [:won, :lost]
  end

  def word(tally), do: tally.letters |> Enum.join(" ")

end
