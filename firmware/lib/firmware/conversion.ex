defmodule Firmware.Conversion do

  def adjust_value_for_digit([single]), do: [0, single]
  def adjust_value_for_digit([_tens, _ones] = value), do: value

  def enable_segment(letter, digit) do
    update_in(digit, [Access.key!(letter), Access.key!(:on)], fn _ -> true end)
  end

  def enable_segments_for_value(digit, value) when value < 10 do
    value
    |> value_to_enabled_segments()
    |> Enum.reduce(digit, &(enable_segment(&1, &2)))
  end

  def to_digits(value) do
    value
    |> Integer.digits()
    |> adjust_value_for_digit()
    |> values_to_digits()
  end

  def to_display(%DateTime{hour: hour, minute: minute}) do
    to_display(hour, minute)
  end
  def to_display([[digit_1, digit_2], [digit_3, digit_4]]) do
    %Firmware.Display{
      digit_1: digit_1,
      digit_2: digit_2,
      digit_3: digit_3,
      digit_4: digit_4,
    }
  end
  def to_display(hour, minute) do
    [hour, minute]
    |> Enum.map(&to_digits/1)
    |> to_display()
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

  def values_to_digits([_tens, _ones] = values) do
    values
    |> Enum.map(&(enable_segments_for_value(%Firmware.Digit{}, &1)))
  end
end
