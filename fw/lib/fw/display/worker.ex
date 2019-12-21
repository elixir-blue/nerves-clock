defmodule FW.Display.Worker do
  use GenServer
  require Logger

  def init(color_stream) do
    Logger.debug("Display.Worker init")
    schedule_update()
    {:ok, color_stream}
  end

  def start_link(color_stream) do
    GenServer.start_link(__MODULE__, color_stream)
  end

  def handle_info(:update_display, color_stream) do
    Logger.debug("Display.Worker handle_info :update_display")
    update_display(color_stream)
    schedule_update()
    {:noreply, color_stream}
  end

  defp set_pixel({hex, x}) do
    color = Blinkchain.Color.parse(hex)
    Blinkchain.set_pixel(%Blinkchain.Point{x: x, y: 0}, color)
  end

  defp schedule_update() do
    Process.send_after(self(), :update_display, 250)
  end

  defp update_display(color_stream) do
    color_stream
    |> Enum.take_random(8)
    |> Enum.map(fn raw -> "#" <> raw end)
    |> Enum.with_index()
    |> Enum.each(&set_pixel/1)

    Blinkchain.render()
  end
end
