# GameOfLife2

## TODO

- ✅create the module implementing the Game Of Life logic
- 🔥I want a Genserver running and able to take an environment and x & y.

- the state will be a tuple of tuple (2 dimensions)
  the elements in the state will be accessed with: `elem(elem(state, 1), 1)`
  the elems will be {value(0 or 1), GenServer pid}
- create the agent keeping the state
  from (1,1) it returns a matrix 3x3, the environment
- create the GenServer in charge of managing one cell

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `game_of_life_2` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:game_of_life_2, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/game_of_life_2](https://hexdocs.pm/game_of_life_2).

