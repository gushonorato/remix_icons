defmodule RemixIcons.MixProject do
  use Mix.Project

  def project do
    [
      app: :remix_icons,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: package()
    ]
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README.md"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Remix-Design/RemixIcon"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:phoenix_live_view, ">= 0.0.0"},
      {:cachex, ">= 0.0.0"}
    ]
  end

  defp aliases do
    [
      remix_download: &remix_download/1,
      remix_clean: &remix_clean/1,
      compile: ["remix_download", "compile"]
    ]
  end

  defp remix_download(_) do
  end

  defp remix_clean(_) do
    System.cmd("rm", ["-rf", "priv/remix"])
  end
end
