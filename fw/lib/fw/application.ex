defmodule FW.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @target Mix.target()

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FW.Supervisor]
    Supervisor.start_link(children(@target), opts)
  end

  # List all child processes to be supervised
  def children("host") do
    [
      {FW.Display.Worker, ColorStream.hex()}
      # Starts a worker by calling: FW.Worker.start_link(arg)
      # {FW.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # {FW.Display.Worker, ColorStream.hex()}
      {FW.Display.Worker, [
        "FF0000",
        "00FF00",
        "0000FF",
        "FFFF00",
        "00FFFF",
        "FF00FF",
        "0FFFF0",
        "00FFFF",
        "F00FFF",
      ]}
      # Starts a worker by calling: FW.Worker.start_link(arg)
      # {FW.Worker, arg},
    ]
  end
end
