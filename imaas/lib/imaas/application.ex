defmodule Imaas.Application do
  @moduledoc false

  use Application

  alias Imaas.Router

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Router,
        port: Application.get_env(:imaas, :port)
      )
    ]

    opts = [strategy: :one_for_one, name: Imaas.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
