defmodule Firmware.Display.ConversionTest do
  use ExUnit.Case
  doctest Firmware.Display.Conversion

  test "converts time to digits" do
    DateTime.utc_now
    |> Firmware.Display.Conversion.time_to_digits
    # IO.inspect DateTime.utc_now().hour
  end

  test "test" do
    Firmware.Display.Conversion.value_to_enabled_segments(12)
    |> IO.inspect
  end

  test "greets the world" do
    assert Firmware.hello() == :world
  end
  test "greets the world2" do
    assert Firmware.hello() == :world
  end
end
