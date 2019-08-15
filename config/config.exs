# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures which GameOfLifeCore to use
config :phx_game_of_life, PhxGameOfLifeWeb.RoomChannel,
  # adapter: GameOfLifeCore.List.Runner
  adapter: GameOfLifeCore.Matrix.Runner

# Configures the endpoint
config :phx_game_of_life, PhxGameOfLifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+Uz7XFou98ypuOhl1eqOXz4JlNrCHiUDYQkUWgrzLD+3gH6iLBMDX8uhIN6JbyAW",
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
