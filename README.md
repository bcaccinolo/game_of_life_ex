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

- ✅modifier la structure du board, il faut que les dimensions soient stockées
- ✅mettre en place le module State qui permet de manipuler un state se trouvant sous forme de liste.
- ✅avancer sur StateAgent.cell_and_environment(line, col)
- ✅StateAgent: récupérer tout le state {state, line, col}
- ✅StateAgent.to_s
- ✅Runner: avoir la méthode `one_generation`
- ✅supprimer Application
- ✅faire un test affichant le temps mis par x iteration
- ✅fix tests
- ✅we have 2 GameOfLifeCore versions, have an interface to easily switch from one to another
  use Behaviour

- Performance optimisation
  - ✅StateAgent.environnement tout gérer en mode liste et non en matrice
  - ✅move the generation of the environment en the Task
    - on passe les valeurs du state et non les pids.
      - stateAgent.environment prend un state de valeurs
  - ✅on ne fait qu'un appel a getState
  - 😿lancer 2 générations en // n'est pas possible...
  - ✅NON - utiliser des Struct et non des Lists
    Iteration de liste est plus rapide que itération de tuple.
  - voir le code avec ncurses on dirait que ça fonctionnait mieux...
  - tracer ce que fait le code et voir ce qui prend le plus de temps

- 😿new version: no Task, just use GenServers
    NOT possible rigth now cause GenServer is not async

- ✅Matrix2: passing the board everytime it's required

- ✅Matrix3: new version: move the environment calculation in the GenServer

- 🔥Matrix4: no //

- try another GameOfLife project in Elixir

## Strucute

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
