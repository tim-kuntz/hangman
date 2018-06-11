# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :phoenix,
  :format_encoders,
    html: Phoenix.Template.HTML,
    svg: Phoenix.Template.HTML,
    json: Poison

# Configures the endpoint
config :gallows, GallowsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8hJXdfeyliDJUBheWOPUKXoYucOfFn8ABX+yu8A/e78w+0jBLk5e2esNXa11ogan",
  render_errors: [view: GallowsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gallows.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
