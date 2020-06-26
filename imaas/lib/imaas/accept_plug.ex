defmodule Imaas.AcceptPlug do
  @moduledoc false

  require Logger

  import Plug.Conn

  def init(opts), do: opts

  def call(%{params: params} = conn, _opts) do
    accept = fetch_image_accept(conn)
    Logger.debug("Accept: #{accept || "none"}")
    %{conn | params: Map.put(params, "format", accept)}
  end

  defp fetch_image_accept(conn) do
    conn
    |> get_req_header("accept")
    |> Enum.filter(&image?/1)
    |> first_image
  end

  defp image?("image/" <> _), do: true
  defp image?(_), do: false

  defp first_image(["image/" <> _ = first | _]), do: first
  defp first_image(_), do: nil
end
