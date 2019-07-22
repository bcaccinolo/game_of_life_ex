# PhxGameOfLife


## todo

- 🔥modifier la structure du board, il faut que les dimensions soient stockées


le state est
[list, lines, columns]



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
