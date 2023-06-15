defmodule Downstream do
  @moduledoc """
  Download HTTP/HTTPS urls directly to file, socket, or stream
  """

  require Logger

  @doc "Download a URL directly to the specified output path."
  def download(url, output_path) do
    stream(url)
    |> Stream.into(File.stream!(output_path))
    |> Stream.run()
  end

  @doc "Stream the contents of a URL, emitting chunks of data"
  def stream(url) do
    Stream.resource(
      fn -> stream_start(url) end,
      &stream_continue/1,
      &stream_end/1
    )
  end

  defp stream_start(url) do
    case :hackney.get(url, [], "", follow_redirect: true) do
      {:ok, status, headers, client} ->
        Logger.debug("status: #{inspect(status)}")
        Logger.debug("headers: #{inspect(headers)}")
        {:ok, client}

      {:error, _} = error ->
        error
    end
  end

  defp stream_continue({:error, _} = error), do: {:halt, error}

  defp stream_continue({:ok, client}) do
    case :hackney.stream_body(client) do
      {:ok, data} ->
        {[data], {:ok, client}}

      :done ->
        {:halt, {:ok, client}}

      {:error, _} = error ->
        {:halt, error}
    end
  end

  defp stream_end({:error, _} = error), do: error
  defp stream_end({:ok, client}), do: :hackney.close(client)
end
