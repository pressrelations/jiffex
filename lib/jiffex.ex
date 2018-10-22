defmodule Jiffex do
  def decode(string, opts \\ []) do
    try do
      decode!(string, opts)
    rescue
      e in Jiffex.Error ->
        {:error, e.message}
    end
  end

  def decode!(string, _opts \\ []) do
    try do
      :jiffy.decode(string, [:use_nil, :return_maps])
    catch
      {:error, reason} ->
        raise Jiffex.Error, "Decode failed with reason '#{inspect(reason)}'"
    end
  end

  def encode(var, opts \\ []) do
    try do
      encode!(var, opts)
    rescue
      e in Jiffex.Error ->
        {:error, e.message}
    end
  end

  def encode!(var, _opts \\ []) do
    try do
      var
      |> remove_struct_keys
      |> :jiffy.encode([:use_nil])
    catch
      {:error, reason} ->
        raise Jiffex.Error, "Encode failed with reason '#{inspect(reason)}'"
    end
  end

  def encode_to_iodata!(var, _opts \\ []), do: encode!(var)

  defp remove_struct_keys(var) when is_map(var) do
    Map.drop(var, [:__struct__])
    |> Enum.map(fn {k,v} ->
      {k, remove_struct_keys(v)}
    end)
    |> Enum.into(%{})
  end
  defp remove_struct_keys(var) when is_list(var) do
    Enum.map(var, fn v -> remove_struct_keys(v) end)
  end
  defp remove_struct_keys(var), do: var
end
