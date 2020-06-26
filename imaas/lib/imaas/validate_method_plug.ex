defmodule Imaas.ValidateMethodPlug do
  @moduledoc false

  import Plug.Conn

  def init(opts), do: opts

  def call(%{method: "POST"} = conn, _) do
    conn
  end

  def call(conn, _) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(400, "Invalid method")
    |> halt
  end
end
