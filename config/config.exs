# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_game_of_life,
  ecto_repos: [PhxGameOfLife.Repo]

# Configures the endpoint
config :phx_game_of_life, PhxGameOfLifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7883G/GmShN+uGiqa5MvOPwHmQ2LqD+HaehceKTeo6Mv5jM1N35ig5YODPWBD5J8",
  render_errors: [view: PhxGameOfLifeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhxGameOfLife.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
