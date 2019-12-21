# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Blinkchain-specific configuration
import_config "blinkchain.exs"

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.

config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

key = Path.join(System.user_home!(), ".ssh/id_rsa.pub")
unless File.exists?(key), do: Mix.raise("No SSH Keys found. Please generate an ssh key")

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(key)
  ]

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger], level: :debug

# Configure nerves_init_gadget.
# See https://hexdocs.pm/nerves_init_gadget/readme.html for more information.

# Setting the node_name will enable Erlang Distribution.
# Only enable this for prod if you understand the risks.
node_name = if Mix.env() != :prod, do: "fw"

config :nerves_init_gadget,
  ifname: "eth0",
  address_method: :dhcp,
  mdns_domain: "nerves.local",
  node_name: node_name,
  node_host: :mdns_domain

# Configure Phoenix application (see wiki)
config :ui, UIWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 80],
  secret_key_base: "W6cRhNEDT4pvEphRZIt3IXXGctpEx1HxZm6cXE1wMtTFq0HJ107LPry71hnXL9Yj",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [view: UIWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UI.PubSub, adapter: Phoenix.PubSub.PG2],
  code_reloader: false

config :phoenix, :json_library, Jason

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.target()}.exs"
