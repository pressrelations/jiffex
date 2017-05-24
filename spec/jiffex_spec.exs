defmodule JiffexSpec do
  use ESpec, async: true

  describe ".encode!" do
    it "should encode data to json" do
      data = %{
        foo: "bar",
        bar: nil,
        x: ["foo"]
      }

      expect(described_module().encode!(data)) |> to(eq("{\"x\":[\"foo\"],\"foo\":\"bar\",\"bar\":null}"))
    end

    it "should remove __struct__ keys" do
      data = %{
        foo: "bar",
        __struct__: 1,
        bar: %{
          __struct__: 1
        },
        x: [
          %{
            __struct__: 1
          }
        ]
      }

      expect(described_module().encode!(data)) |> to(eq("{\"x\":[{}],\"foo\":\"bar\",\"bar\":{}}"))
    end
  end

  describe ".decode!" do
    it "should decode encoded data" do
      data = "{\"x\":[\"foo\"],\"foo\":\"bar\",\"bar\":null}"

      expect(described_module().decode!(data)) |> to(eq(
        %{
          "foo" => "bar",
          "bar" => nil,
          "x" => ["foo"]
        }
      ))
    end
  end
end
