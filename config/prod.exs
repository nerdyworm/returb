use Mix.Config

config :simple, Returb.Endpoint,
  http: [port: {:system, "PORT"}, compress: true],
  url: [scheme: "https", host: "sleepy-shore-92135.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true

config :logger, level: :info

config :simple, Returb.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

