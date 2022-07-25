defmodule Firmware.Worker do
  use GenServer
  require Logger

  def init(colors) do
    Logger.debug("Display.Worker init")
    schedule_update()

    display = %Firmware.Display{
      digit_1: %Firmware.Digit{},
      digit_2: %Firmware.Digit{},
      digit_3: %Firmware.Digit{},
      digit_4: %Firmware.Digit{},
    }

    {:ok, [convert(colors), display]}
  end

  def start_link(colors) do
    GenServer.start_link(__MODULE__, colors)
  end

  def handle_info(:update_display, [colors, display]) do
    DateTime.utc_now()
    |> update_display(colors, display)

    schedule_update()

    {:noreply, [rotate(colors), display]}
  end

  defp convert(colors) do
    Enum.map(colors, fn raw -> "#" <> raw end)
  end

  defp rotate([head | tail]), do: tail ++ [head]

  defp set_pixel({hex, x}) do
    color = Blinkchain.Color.parse(hex)
    Blinkchain.set_pixel(%Blinkchain.Point{x: x, y: 0}, color)
  end

  defp schedule_update() do
    Process.send_after(self(), :update_display, 250)
  end

  defp update_display(_time, colors, _display) do
    colors
    |> Enum.with_index()
    |> Enum.each(&set_pixel/1)

    Blinkchain.render()
  end
end
