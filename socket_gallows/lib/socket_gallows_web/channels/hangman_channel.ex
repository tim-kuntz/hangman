defmodule SocketGallowsWeb.HangmanChannel do

  use Phoenix.Channel

  require Logger

  def join("hangman:game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    Process.send_after(self(), {:tick, 60}, 1000)
    {:ok, socket }
  end

  def handle_in("tally", _, socket) do
    tally = socket.assigns.game |> Hangman.tally()
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("make_move", guess, socket) do
    tally = socket.assigns.game |> Hangman.make_move(guess)
    push(socket, "tally", tally)
    { :noreply, socket }
  end

  def handle_in("new_game", _, socket) do
    socket = socket |> assign(:game, Hangman.new_game())
    handle_in("tally", nil, socket)
  end

  def handle_in(topic, _, socket) do
    Logger.error("Client pushed a message to the invalid topic '#{topic}'")
    {:noreply, socket}
  end

  def handle_info({:tick, seconds_left = 0}, socket) do
    push(socket, "countdown", %{seconds: seconds_left})
    tally = socket.assigns.game |> Hangman.timeout()
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  def handle_info({:tick, seconds_left}, socket) do
    push(socket, "countdown", %{seconds: seconds_left})
    Process.send_after(self(), {:tick, seconds_left - 1}, 1000)
    {:noreply, socket}
  end

end

