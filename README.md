# RemixIcons

A Phoenix LiveView component library for using [Remix Icons](https://remixicon.com/) in your Elixir applications. This library provides over 2,800 pixel-perfect icons with automatic SVG downloading, caching, and easy integration with Phoenix components.

## Features

- 🎨 **2,800+ Icons**: Access the complete Remix Icon set
- 📦 **Automatic Download**: Icons are automatically downloaded during compilation
- ⚡ **Performance**: Built-in caching with Cachex for optimal performance
- 🔧 **Phoenix Component**: Simple, idiomatic Phoenix LiveView integration
- 🎯 **Type Safe**: Compile-time icon name validation

## Installation

Add `remix_icons` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:remix_icons, "~> 0.1.0"}
  ]
end
```

The package will automatically download Remix Icons v4.7.0 during compilation.

## Configuration

Add the Cachex cache to your application's supervision tree in `lib/your_app/application.ex`:

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

Import the component in your Phoenix LiveView or component:

```elixir
import RemixIcons
```

Then use the `icon/1` component with the icon name:

```heex
<.icon name="home-line" />
<.icon name="user-fill" />
<.icon name="settings-3-line" />
```

### Finding Icon Names

Browse all available icons at [remixicon.com](https://remixicon.com/). The icon name corresponds to the filename without the `.svg` extension.

For example:
- `ri-home-line` → use `"home-line"`
- `ri-user-fill` → use `"user-fill"`
- `ri-arrow-right-line` → use `"arrow-right-line"`

## Icon Categories

Remix Icons are organized into categories:

- **Business**: charts, briefcase, bank, etc.
- **Communication**: chat, message, mail, etc.
- **Design**: tools, palette, brush, etc.
- **Development**: code, terminal, bug, etc.
- **Device**: smartphone, laptop, camera, etc.
- **Document**: file, folder, clipboard, etc.
- **Editor**: formatting, align, list, etc.
- **Finance**: money, wallet, coin, etc.
- **Health**: heart, medicine, hospital, etc.
- **Logos**: social media, brands, etc.
- **Map**: location, navigation, compass, etc.
- **Media**: play, pause, music, etc.
- **System**: settings, notification, search, etc.
- **User**: profile, account, team, etc.
- **Weather**: sun, cloud, rain, etc.

## How It Works

1. **Download**: During compilation, the library downloads the official Remix Icon SVG files (v4.7.0) to `priv/icons/`
2. **Cache**: Icon SVGs are cached in memory using Cachex for fast rendering
3. **Render**: The component reads and injects the raw SVG content into your templates

## Commands

- `mix remix_download` - Manually download icons
- `mix remix_clean` - Remove downloaded icons

## Requirements

- Elixir ~> 1.18
- Phoenix LiveView >= 0.0.0
- Cachex >= 0.0.0

## License

This package is released under the MIT License.

Remix Icons are licensed under Apache License 2.0. See [Remix Icon License](https://github.com/Remix-Design/RemixIcon/blob/master/License) for details.

## Links

- [Remix Icon Official Site](https://remixicon.com/)
- [Remix Icon GitHub](https://github.com/Remix-Design/RemixIcon)

