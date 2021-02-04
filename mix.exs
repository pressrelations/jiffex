defmodule Jiffex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :jiffex,
      version: "0.3.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps(),
      deps_path: System.get_env("ELIXIR_DEPS_PATH") || "deps",
      build_path: System.get_env("ELIXIR_BUILD_PATH") || "_build"
    ]
  end

  def application, do: [applications: []]

  defp deps do
    [
      {:jiffy, github: "davisp/jiffy"},
      {:espec, "~> 1.4", only: :test}
    ]
  end
end
