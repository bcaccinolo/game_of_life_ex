# GameOfLife2

## TODO

- ✅create the module implementing the Game Of Life logic
- ✅the GenServer keeps a simple state of the cell.
- ✅the GenServer is able to take an environment and x & y
    - to calculate the new state for the cell
    - update the new state

- the state of one cell will be the GenSenver containing as a state the value of the cell

- the Board state will be a double tuple containing GenServers.
  the elements in the state will be accessed with: `elem(elem(state, 1), 1)`
  this state is stored in an Agent.

- 🔥create the Agent building and storing the state.

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

