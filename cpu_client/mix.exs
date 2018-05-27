defmodule CpuClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :cpu_client,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :dictionary, path: "../dictionary" },
      { :text_client, path: "../text_client" },
      { :hangman, path: "../hangman" }
    ]
  end
end
