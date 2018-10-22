defmodule Jiffex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :jiffex,
      version: "0.2.1",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps()
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
