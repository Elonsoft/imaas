defmodule Imaas.MixProject do
  use Mix.Project

  def project do
    [
      app: :imaas,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Imaas.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [{:plug_cowboy, "~> 2.0"}]
  end
end
