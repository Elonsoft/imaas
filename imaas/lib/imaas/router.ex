defmodule Imaas.Router do
  @moduledoc false

  use Plug.Builder

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["application/x-www-form-urlencoded"]

  plug Imaas.ValidateMethodPlug
  plug Imaas.EnsureUploadPlug
  plug Imaas.FetchOptionsPlug
  plug Imaas.AcceptPlug
  plug Imaas.ConverterPlug
end
