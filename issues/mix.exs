defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      version: "1.0.0-dev",
      deps: deps(),

      # docs
      escript: escript_config(),
      elixir: "~> 1.16",
      source_url: "https://github.com/ismaelezequiel/elixir",
      homepage_url: "https://github.com/ismaelezequiel/elixir",
      start_permanent: Mix.env() == :prod,
      docs: [
        main: "Issues App",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison,  "~> 2.2"},
      {:poison,     "~> 6.0"},
      {:ex_doc,     "~> 0.34.2"},
      {:earmark,    "~> 1.4.47"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
