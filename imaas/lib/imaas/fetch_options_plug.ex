defmodule Imaas.FetchOptionsPlug do
  @moduledoc false

  require Logger

  def init(opts), do: opts

  def call(%{params: %{"options" => options} = params} = conn, _) do
    options = options |> URI.decode() |> String.split(" ", trim: true)
    Logger.debug("Options: #{inspect(options)}")
    %{conn | params: %{params | "options" => options}}
  end

  def call(%{params: params} = conn, _) do
    Logger.debug("Options: []")
    %{conn | params: Map.put(params, "options", [])}
  end
end
