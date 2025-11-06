defmodule RemixIcons do
  use Phoenix.Component

  def icon(%{name: icon_name} = assigns) do
    cache_result =
      Cachex.fetch(:icons, "__remix_icons__/#{icon_name}", fn ->
        icons_path = Path.join([:code.priv_dir(:remix_icons), "icons"])
        svg_files = Path.wildcard(Path.join(icons_path, "**/*.svg"))

        filename =
          Enum.find(svg_files, fn svg_file ->
            icon_name == Path.basename(svg_file, ".svg")
          end)

        if is_nil(filename), do: raise("Icon #{icon_name} not found")

        assigns = assign(assigns, :svg_content, File.read!(filename))

        ~H"""
        {Phoenix.HTML.raw(@svg_content)}
        """
      end)

    case cache_result do
      {:ok, template} ->
        template

      {:commit, template} ->
        template
    end
  end
end
