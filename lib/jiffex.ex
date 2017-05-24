defmodule Jiffex do
  def decode!(string) do
    :jiffy.decode(string, [:use_nil, :return_maps])
  end

  def encode!(var) do
    var
    |> remove_struct_keys
    |> :jiffy.encode([:use_nil])
  end

  def encode_to_iodata!(var), do: encode!(var)

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
