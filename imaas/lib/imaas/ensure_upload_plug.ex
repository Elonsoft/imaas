defmodule Imaas.EnsureUploadPlug do
  @moduledoc false

  import Plug.Conn

  require Logger

  alias Plug.Upload

  def init(opts), do: opts

  def call(%{params: %{"image" => %Upload{} = upload}} = conn, _) do
    %{path: path, content_type: mime} = upload
    Logger.debug("Upload: #{path} #{mime}")
    conn
  end

  def call(conn, _) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(400, "Missing image")
    |> halt
  end
end
