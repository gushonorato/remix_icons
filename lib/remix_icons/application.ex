defmodule RemixIcons.Application do
  @moduledoc false
  import Cachex.Spec

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Cachex, [:icons, [expiration: expiration(lazy: false, interval: nil)]]}
    ]

    opts = [strategy: :one_for_one, name: RemixIcons.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
