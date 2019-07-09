defmodule PhxGameOfLife.Repo do
  use Ecto.Repo,
    otp_app: :phx_game_of_life,
    adapter: Ecto.Adapters.Postgres
end
