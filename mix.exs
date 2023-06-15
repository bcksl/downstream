defmodule Downstream.MixProject do
  use Mix.Project

  @name :downstream
  @version "0.1.0"
  @description "Stream HTTP/S response bodies"
  @author "bcksl <bcksl@proton.me>"
  @source_url "https://github.com/bcksl/downstream"

  def project do
    [
      app: @name,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: preferred_cli_env(),
      deps: deps(),
      package: package(),
      test_coverage: test_coverage(),
      docs: docs(),
      name: Macro.camelize("#{@name}"),
      description: @description
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def cli do
    [
      default_task: :compile,
      preferred_envs: preferred_cli_env()
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.18"},

      # Development, testing, analysis, documentation, and release tools
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.12.2", only: [:dev, :test], runtime: false},
      {:doctor, "~> 0.21.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.16.1", only: [:dev, :test]},
      {:ex_check, "~> 0.15.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.29.4", only: [:dev, :test], runtime: false},
      {:git_hooks, "~> 0.7.3", only: [:dev, :test]},
      {:git_ops, "~> 2.6", only: [:dev, :test]}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      formatters: ~w(html epub),
      extras: ~w(README.md CHANGELOG.md)
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp package do
    [
      name: "#{@name}",
      files: ~w(.formatter.exs config lib mix.exs README* LICENSE*),
      maintainers: [@author],
      licenses: ~w(MIT),
      links: %{
        GitHub: @source_url
      }
    ]
  end

  defp elixirc_paths(:test), do: ~w(lib test/support)
  defp elixirc_paths(_), do: ~w(lib)

  defp preferred_cli_env do
    [
      docs: :dev,
      check: :test,
      "hex.outdated": :test,
      "deps.audit": :test,
      audit: :test,
      "hex.audit": :test,
      format: :test,
      dialyzer: :test,
      credo: :test,
      sobelow: :test,
      doctor: :test,
      test: :test,
      "git_hooks.run": :test,
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test,
      "coveralls.github": :test
    ]
  end
end
