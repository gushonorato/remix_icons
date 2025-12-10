defmodule RemixIcons do
  use Phoenix.Component

  import Cachex.Spec
  require Logger

  attr :name, :string, required: true

  def icon(%{name: icon_name} = assigns) do
    cache_result =
      Cachex.fetch(:icons, "__remix_icons__/#{icon_name}", fn ->
        icons_path = Path.join([:code.priv_dir(:remix_icons), "icons"])

        # Verifica se o diretório existe
        unless File.exists?(icons_path) do
          raise "Icons directory not found at #{icons_path}. Make sure priv/ files are included in the package."
        end

        svg_files = Path.wildcard(Path.join(icons_path, "**/*.svg"))

        filename =
          Enum.find(svg_files, fn svg_file ->
            icon_name == Path.basename(svg_file, ".svg")
          end)

        if is_nil(filename) do
          raise "Icon #{icon_name} not found in #{icons_path}"
        end

        assigns = assign(assigns, :svg_content, File.read!(filename))

        ~H"""
        {Phoenix.HTML.raw(@svg_content)}
        """
      end)

    Logger.debug("cache_result: #{inspect(cache_result)}")

    case cache_result do
      {:ok, template} ->
        template

      {:commit, template} ->
        template

      {:error, error} ->
        raise error
    end
  end

  def cache() do
    {Cachex, [:icons, [expiration: expiration(lazy: false, interval: nil)]]}
  end
end
