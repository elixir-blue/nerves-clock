defmodule Firmware.Conversion do

  def adjust_value_for_digit([single]), do: [0, single]
  def adjust_value_for_digit([_tens, _ones] = value), do: value

  # def apply_time(%DateTime{hour: hour, minute: minute}, display) do
  #   apply_time(hour, minute)
  # end
  # def apply_time(hour, minute, display) do
  #   # hour_digits =
  #   # apply_value_to_position(hour, )
  #   [hour, minute]
  #   |> Enum.map(&value_to_enabled_segments/1)
  #   |> IO.inspect
  # end

  def to_digits(value) do
    value
    |> Integer.digits()
    |> adjust_value_for_digit()
    |> values_to_digits()
  end

  def enable_segment(letter, digit) do
    update_in(digit, [Access.key!(letter), Access.key!(:on)], fn _ -> true end)
  end

  def enable_segments_for_value(digit, value) when value < 10 do
    value
    |> value_to_enabled_segments()
    |> Enum.reduce(digit, fn (e, acc) -> enable_segment(e, acc) end)
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

  def values_to_digits([tens, ones]) do
    [
      enable_segments_for_value(%Firmware.Digit{}, tens),
      enable_segments_for_value(%Firmware.Digit{}, ones),
    ]
  end
end
