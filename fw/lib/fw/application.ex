defmodule FW.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FW.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: FW.Worker.start_link(arg)
        # {FW.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      {FW.Display.Worker, ColorStream.hex()}
      # Children that only run on the host
      # Starts a worker by calling: FW.Worker.start_link(arg)
      # {FW.Worker, arg},
    ]
  end

  def children(_target) do
    [
      {FW.Display.Worker, ColorStream.hex(saturation: 1, value: 1) |> Enum.take(256)}
      # Children for all targets except host
      # Starts a worker by calling: FW.Worker.start_link(arg)
      # {FW.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:rpi0_test, :target)
  end
end
