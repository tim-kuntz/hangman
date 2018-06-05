defmodule Hangman.Server do

  use GenServer

  alias Hangman.Game

  # {:ok, pid} = Hangman.Server.start_link()
  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    IO.puts "Initializing game on #{node()}"
    { :ok, Game.new_game() }
  end

  # tally = GenServer.call(pid, {:make_move, "a"})
  def handle_call({ :make_move, guess }, _from, game) do
    { game, tally } = Game.make_move(game, guess)
    { :reply, tally, game }
  end

  def handle_call({ :tally }, _from, game) do
    { :reply, Game.tally(game), game }
  end
end
