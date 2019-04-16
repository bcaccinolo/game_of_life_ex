# GameOfLife2

## TODO
- ✅create the module implementing the Game Of Life logic
- ✅the GenServer keeps a simple state of the cell.
- ✅the GenServer is able to take an environment and x & y
    - to calculate the new state for the cell
    - update the new state
- ✅create state builder.
- ✅create the agent keeping the state
    from (1,1) it returns a matrix 3x3, the environment
- ✅the Agent can update the board state. This should be useless normaly.


# NOTES

- 📝the state of one cell will be the GenSenver containing as a state the value of the cell

- 📝the Board state will be a GenServer containing the cell state.
  the elements in the state will be accessed with: `elem(elem(state, 1), 1)`
  this state is stored in an Agent.

- 📝Coordinates in the matrix

    [[1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]]

    x = 0 y = 0 > 1
    x = 0 y = 1 > 2
    x = 1 y = 0 > 4
    x = 1 y = 1 > 5

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

