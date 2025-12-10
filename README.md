# RemixIcons

A Phoenix LiveView component library for using [Remix Icons](https://remixicon.com/) in your Elixir applications. This library provides over 2,800 pixel-perfect icons with automatic SVG downloading, caching, and easy integration with Phoenix components.

## Features

- 🎨 **2,800+ Icons**: Access the complete Remix Icon set
- ⚡ **Performance**: Built-in caching with Cachex for optimal performance
- 🔧 **Phoenix Component**: Simple, idiomatic Phoenix LiveView integration
- 🎯 **Type Safe**: Run-time icon name validation

## Installation

Add `remix_icons` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:remix_icons, "~> 4.7.0"}
  ]
end
```

The package includes Remix Icons v4.7.0.

## Configuration

Add the RemixIcons cache to your application's supervision tree in `lib/your_app/application.ex`:

```elixir
def start(_type, _args) do
  children = [
    # ... other children
    RemixIcons.cache()
  ]

  opts = [strategy: :one_for_one, name: YourApp.Supervisor]
  Supervisor.start_link(children, opts)
end
```

## Usage

We recommend adding an icon component wrapper in your `CoreComponents` module. This allows you to use the `ri-` prefix (matching the Remix Icon naming convention) and add custom styling. The icon will inherit the styles from the wrapping div:

```elixir
attr :name, :string, required: true
attr :class, :string, default: nil

def icon(%{name: "ri-" <> name} = assigns) do
  assigns = assign(assigns, :name, name)

  ~H"""
  <div class={@class}>
    <RemixIcons.icon name={@name} />
  </div>
  """
end
```

Then use it in your templates:

```heex
<.icon name="ri-home-line" class="w-6 h-6" />
<.icon name="ri-user-fill" class="text-blue-500" />
```

### Finding Icon Names

Browse all available icons at [remixicon.com](https://remixicon.com/). When using the wrapper recommended on "Usage" section, the icon names are identical to those shown on the website:

```heex
<.icon name="ri-home-line" />
<.icon name="ri-user-fill" />
<.icon name="ri-arrow-right-line" />
```

If using `RemixIcons.icon` directly, omit the `ri-` prefix:

```heex
<RemixIcons.icon name="home-line" />
<RemixIcons.icon name="user-fill" />
<RemixIcons.icon name="arrow-right-line" />
```

## Contributions

This library follows the version numbering of the official [Remix Icon repository](https://github.com/Remix-Design/RemixIcon). When a new version of Remix Icons is released, this package will be updated to match that version number, ensuring consistency and easy tracking of which icon set version you're using.

### Updating Icons

To update to a new version of Remix Icons:

1. Update the `@remix_icon_version` variable in `mix.exs` to the desired version
2. Clean the existing icons:
   ```bash
   mix remix_clean
   ```
3. Download the new icons:
   ```bash
   mix remix_download
   ```
4. Update the package version in `mix.exs` to match the Remix Icon version
5. Test your application to ensure all icons are working correctly

### Useful Links

- [Remix Icon Official Site](https://remixicon.com/)
- [Remix Icon GitHub](https://github.com/Remix-Design/RemixIcon)

## Requirements

- Elixir ~> 1.18
- Phoenix LiveView >= 0.0.0
- Cachex >= 0.0.0

## License

This package is released under the MIT License.

Remix Icons are licensed under Apache License 2.0. See [Remix Icon License](https://github.com/Remix-Design/RemixIcon/blob/master/License) for details.