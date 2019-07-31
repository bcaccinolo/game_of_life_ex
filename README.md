# PhxGameOfLife

## todo

- ✅modifier la structure du board, il faut que les dimensions soient stockées

- ✅mettre en place le module State qui permet de manipuler un state se trouvant sous forme de liste.

- ✅avancer sur StateAgent.cell_and_environment(line, col)

- ✅StateAgent: récupérer tout le state {state, line, col}

- ✅StateAgent.to_s

- ✅Runner: avoir la méthode `one_generation`

- ✅supprimer Application

- ✅faire un test affichant le temps mis par x iteration

- 🔥we have 2 GameOfLifeCore versions, have an interface to easily switch from one to another

- 🔥Performance optimisation
  - ✅StateAgent.environnement tout gérer en mode liste et non en matrice
  - ✅move the generation of the environment en the Task
    - on passe les valeurs du state et non les pids.
      - stateAgent.environment prend un state de valeurs
  - ✅on ne fait qu'un appel a getState
  - 😿lancer 2 générations en // n'est pas possible...
  - ✅NON - utiliser des Struct et non des Lists
    Iteration de liste est plus rapide que itération de tuple.

  - 🔥voir le code avec ncurses on dirait que ça fonctionnait mieux...

  - tracer ce que fait le code et voir ce qui prend le plus de temps



## Performance tracking

- Board 100x100 : 7.2 sec
- Board 100x100 : 6.0 sec > the code handles list and no more matrix


## Notes

le state est
{ list, lines, columns }

## the next part

RoomChannel doit consommer GoL et non l'inverse.
Il faut donc définir l'api GoL pour cela:
 - Runner.init_board : initialise le board de GenServers
 - Runner.update_once : lance une itération de mise à jour

## the rest

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## Helpers

0, 0, 1, 0,
1, 0, 1, 0,
0, 1, 0, 0,
0, 1, 1, 0,
0, 0, 0, 0

00101010010001100000

1, 0, 0,
1, 1, 0,
1, 0, 0

1, 0, 0, 1, 1, 0, 1, 0, 0



