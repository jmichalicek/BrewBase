# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :brewbase,
  ecto_repos: [Brewbase.Repo]

# Configures the endpoint
config :brewbase, Brewbase.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: Brewbase.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Brewbase.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# will this config for identity cause problems with other auth types?
config :ueberauth, Ueberauth,
  base_path: "/",  #default is /auth
  providers: [
    identity: { Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        uid_field: :email,
        nickname_field: :email,
        request_path: "/login",
        callback_path: "/login",
        param_nesting: "auth"
      ] }
  ]

  #config :invitatr, Invitatr.Mailer,
  #adapter: Bamboo.LocalAdapter
  #adapter: Bamboo.SMTPAdapter,
  #server: System.get_env("SMTP_HOST"),
  #port: System.get_env("SMTP_PORT"),
  #username: System.get_env("SMTP_USERNAME"),
  #password: System.get_env("SMTP_PASSWORD"),
  #tls: :if_available,
  #ssl: false,retries: 1
  #

  # phoenix_users app config testing
config :phoenix_users,
  ecto_repo: Brewbase.Repo,
  user_model: Brewbase.User

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Brewbase",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  #secret_key: %{"k" => "GENERATE_ME", "kty" => "oct"},
  secret_key: System.get_env("GUARDIAN_SECRET_KEY"),
  serializer: Brewbase.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
