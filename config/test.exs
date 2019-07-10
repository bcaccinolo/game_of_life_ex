use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_game_of_life, PhxGameOfLifeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
