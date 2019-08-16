# PhxGameOfLife

## Possible JS
```
var canvas = document.getElementById("gol");
var ctx = canvas.getContext("2d");

data.split('\n').forEach((line, y) => {
  Array.from(line).forEach((cell, x) => {
    ctx.fillStyle = !!parseInt(cell) ? "#000" : "#fff";
    ctx.fillRect((x-1)*10, (y-1)*10, 10, 10);
  })
})
```

## todo

- 🔥Matrix4: no //

- try another GameOfLife project in Elixir

## Structure

- List version. The data structure is list

- Matrix same version but using tuple of tuple

- Matrix2: passing the board everytime it's required

- Matrix3: move the environment calculation in the GenServer

- Matrix4: no //

## Performance tracking

- Board 100x100 : 7.2 sec
- Board 100x100 : 6.0 sec > the code handles list and no more matrix

## Notes

le state est
{ list, lines, columns }

## start the server

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
