# Jiffex

Small hex that uses :jiffy (see [davisp/jiffy](https://github.com/davisp/jiffy)) to decode and encode JSON data. Can be used with phoenix ([phoenixframework/phoenix](https://github.com/phoenixframework/phoenix)).

```elixir
config :phoenix, :format_encoders,
  json: Jiffex
```

## Installation

```elixir
def deps do
  [{:jiffex, github: "pressrelations/jiffex"}]
end
```
