defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert Regex.match?(~r/^[a-z]+$/, game.letters |> Enum.join)
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of a letter is not already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of a letter is already used" do
    game = Game.new_game()
    {game, _} = Game.make_move(game, "x")
    {game, _} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a :won game" do
    game = Game.new_game("wibble")
    game = Enum.reduce(game.letters,
                game,
                fn(x, acc) ->
                  {new_game, _} = Game.make_move(acc, x)
                  new_game
                end)
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "a bad guess" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "an invalid guess" do
    game = Game.new_game()
    ["X", "xx", "9", "!"]
    |> Enum.each(fn(guess) ->
      {game, _} = Game.make_move(game, guess)
      assert game.game_state == :invalid_guess
      assert game.turns_left == 7
    end)
    assert game.turns_left == 7
  end

  test "a lost game" do
    game = Game.new_game("w")
    {game, _} = Game.make_move(game, "a")
    {game, _} = Game.make_move(game, "b")
    {game, _} = Game.make_move(game, "c")
    {game, _} = Game.make_move(game, "d")
    {game, _} = Game.make_move(game, "e")
    {game, _} = Game.make_move(game, "f")
    {game, _} = Game.make_move(game, "g")
    assert game.game_state == :lost
    assert game.turns_left == 0
  end

  test "a lost game refactored" do
    game = Game.new_game("w")
    letters = String.codepoints("abcdefg")
    game = Enum.reduce(letters, game, fn(letter, acc) ->
      {game, _} = Game.make_move(acc, letter)
      game
    end)
    assert game.game_state == :lost
    assert game.turns_left == 0
  end
end

