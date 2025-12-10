defmodule RemixIcons.MixProject do
  use Mix.Project

  @remix_icon_version "4.7.0"

  def project do
    [
      app: :remix_icons,
      version: @remix_icon_version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: package()
    ]
  end

  defp package do
    [
      description:
        "A Phoenix LiveView component library for using Remix Icons with over 2,800 pixel-perfect icons, automatic SVG downloading, and built-in caching",
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
      {:cachex, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      remix_download: &remix_download/1,
      remix_clean: &remix_clean/1
    ]
  end

  defp remix_download(_) do
    icons_path = Path.join(["priv", "icons"])

    if File.exists?(icons_path) do
      Mix.shell().info("Icons already downloaded at #{icons_path}")
    else
      Mix.shell().info("Downloading Remix Icons v#{@remix_icon_version}...")

      url =
        "https://github.com/Remix-Design/RemixIcon/archive/refs/tags/v#{@remix_icon_version}.zip"

      zip_path = Path.join(["priv", "remix_icons.zip"])
      extract_path = Path.join(["priv"])

      File.mkdir_p!("priv")

      case download_file(url, zip_path) do
        :ok ->
          Mix.shell().info("Extracting icons...")

          {:ok, _} =
            :zip.unzip(String.to_charlist(zip_path), [{:cwd, String.to_charlist(extract_path)}])

          extracted_icons_path =
            Path.join([extract_path, "RemixIcon-#{@remix_icon_version}", "icons"])

          File.rename!(extracted_icons_path, icons_path)

          File.rm!(zip_path)
          File.rm_rf!(Path.join([extract_path, "RemixIcon-#{@remix_icon_version}"]))

          Mix.shell().info("Icons downloaded successfully to #{icons_path}")

        {:error, reason} ->
          Mix.raise("Failed to download icons: #{inspect(reason)}")
      end
    end
  end

  defp download_file(url, dest) do
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    case :httpc.request(:get, {String.to_charlist(url), []}, [ssl: [verify: :verify_none]], []) do
      {:ok, {{_, 302, _}, headers, _}} ->
        location = :proplists.get_value(~c"location", headers)
        download_file(to_string(location), dest)

      {:ok, {{_, 200, _}, _, body}} ->
        File.write!(dest, body)
        :ok

      {:ok, {{_, status_code, _}, _, _}} ->
        {:error, "HTTP status #{status_code}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp remix_clean(_) do
    File.rm_rf!("priv/icons")
    Mix.shell().info("Icons cleaned from priv/icons")
  end
end
