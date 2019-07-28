# PhxGameOfLife

## todo

- ✅modifier la structure du board, il faut que les dimensions soient stockées

- ✅mettre en place le module State qui permet de manipuler un state se trouvant sous forme de liste.

- ✅avancer sur StateAgent.cell_and_environment(line, col)

- ✅StateAgent: récupérer tout le state {state, line, col}

- 🔥Runner: avoir la méthode `disp` qui convertie en chaîne de caractère

- Runner: avoir la méthode `one_generation`
  - not finished : do the test

- supprimer Application

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

