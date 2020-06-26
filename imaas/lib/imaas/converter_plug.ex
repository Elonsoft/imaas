defmodule Imaas.ConverterPlug do
  @moduledoc false

  import Plug.Conn

  alias Imaas.Converter

  def init(opts), do: opts

  def call(%{params: params} = conn, _) do
    %{"image" => upload, "options" => options, "format" => format} = params

    case Converter.convert(upload, options, format) do
      {:ok, mime, image_path} ->
        conn
        |> put_resp_content_type(mime)
        |> send_file(200, image_path)
        |> halt

      {:error, exit_code, stdout} ->
        conn
        |> put_resp_content_type("text/plain")
        |> put_resp_header("x-exit-code", "#{exit_code}")
        |> send_resp(400, stdout)
        |> halt
    end
  end
end
