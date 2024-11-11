import Config

config :issues,
  github_url: "https://api.github.com"

config :logger,
  backends: [:console],
  compile_time_purge_matching: [
    [level_lower_then: :info]
  ]
