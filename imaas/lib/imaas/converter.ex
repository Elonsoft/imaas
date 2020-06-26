defmodule Imaas.Converter do
  @moduledoc false

  alias Plug.Upload

  def convert(%Upload{path: path, content_type: mime}, options, accept) do
    converted_path = converted_path(path, mime, accept)
    args = [path] ++ options ++ [converted_path]

    File.write!("image.png", File.read!(path))

    case System.cmd("convert", args, stderr_to_stdout: true) do
      {_, 0} ->
        File.cp!(converted_path, path)
        File.rm!(converted_path)
        {:ok, final_mime(mime, accept), path}

      {stdout, exit_code} ->
        {:error, exit_code, stdout}
    end
  end

  defp converted_path(path, mime, nil) do
    converted_path(path, nil, mime)
  end

  defp converted_path(path, _, "image/" <> ext) do
    "#{path}_conveted.#{ext}"
  end

  defp converted_path(path, _, unknown) do
    "#{path}_conveted.#{String.replace(unknown, "/", "_")}"
  end

  defp final_mime(mime, nil), do: mime
  defp final_mime(_, mime), do: mime
end
