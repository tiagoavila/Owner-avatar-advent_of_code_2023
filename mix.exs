defmodule AdventOfCode2023.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2023,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AdventOfCode2023, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:interval_tree, "~> 0.1.0"},
      {:dialyxir, "~> 0.4", only: [:dev]},
      {:excoveralls, "~> 0.18", only: :test},
      {:req, "~> 0.4.5"},
      {:combination, "~> 0.0.3"},
      {:benchfella, "~> 0.3.0"},
      {:murmur, "~> 1.0"},
      {:qex, "~> 0.5"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
