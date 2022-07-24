defmodule Firmware.Display.Conversion do

  def time_to_digits(%DateTime{hour: hour, minute: minute, second: second}) do
    time_to_digits(hour, minute, second)
  end
  def time_to_digits(hour, minute, second) do
    [hour, minute, second]
    |> Enum.map(&value_to_enabled_segments/1)
    |> IO.inspect
  end

  def value_to_enabled_segments(0), do: [:a, :b, :c, :d, :e, :f]
  def value_to_enabled_segments(1), do: [:b, :c]
  def value_to_enabled_segments(2), do: [:a, :b, :d, :e, :g]
  def value_to_enabled_segments(3), do: [:a, :b, :c, :d, :g]
  def value_to_enabled_segments(4), do: [:b, :c, :f, :g]
  def value_to_enabled_segments(5), do: [:a, :c, :d, :f, :g]
  def value_to_enabled_segments(6), do: [:a, :c, :d, :e, :f, :g]
  def value_to_enabled_segments(7), do: [:a, :b, :c]
  def value_to_enabled_segments(8), do: [:a, :b, :c, :d, :e, :f, :g]
  def value_to_enabled_segments(9), do: [:a, :b, :c, :d, :f, :g]
  def value_to_enabled_segments(x) when x <= 60 do
    x
    |> Integer.digits
    |> Enum.map(&value_to_enabled_segments/1)
  end

end
