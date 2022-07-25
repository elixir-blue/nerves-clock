defmodule Firmware.ConversionTest do
  use ExUnit.Case
  doctest Firmware.Conversion

  test "adjust_value_for_digit 1" do
    [tens, ones] = Firmware.Conversion.adjust_value_for_digit([5])
    assert tens == 0
    assert ones == 5
  end

  test "adjust_value_for_digit 2" do
    [tens, ones] = Firmware.Conversion.adjust_value_for_digit([1, 5])
    assert tens == 1
    assert ones == 5
  end

  test "enable_segment" do
    digit = %Firmware.Digit{}
    updated = Firmware.Conversion.enable_segment(:c, digit)
    assert updated.c.on == true
  end

  test "enable_segments_for_value" do
    digit = %Firmware.Digit{}
    updated = Firmware.Conversion.enable_segments_for_value(digit, 9)
    assert updated.a.on == true
    assert updated.b.on == true
    assert updated.c.on == true
    assert updated.d.on == true
    assert updated.e.on == false
    assert updated.f.on == true
    assert updated.g.on == true
  end

  test "to_digits 1" do
    [tens, ones] = Firmware.Conversion.to_digits(5)
    assert tens.a.on == true
    assert tens.b.on == true
    assert tens.c.on == true
    assert tens.d.on == true
    assert tens.e.on == true
    assert tens.f.on == true
    assert tens.g.on == false
    assert ones.a.on == true
    assert ones.b.on == false
    assert ones.c.on == true
    assert ones.d.on == true
    assert ones.e.on == false
    assert ones.f.on == true
    assert ones.g.on == true
  end

  test "to_digits 2" do
    [tens, ones] = Firmware.Conversion.to_digits(12)
    assert tens.a.on == false
    assert tens.b.on == true
    assert tens.c.on == true
    assert tens.d.on == false
    assert tens.e.on == false
    assert tens.f.on == false
    assert tens.g.on == false
    assert ones.a.on == true
    assert ones.b.on == true
    assert ones.c.on == false
    assert ones.d.on == true
    assert ones.e.on == true
    assert ones.f.on == false
    assert ones.g.on == true
  end

  test "to_digits 3" do
    [tens, ones] = Firmware.Conversion.to_digits(45)
    assert tens.a.on == false
    assert tens.b.on == true
    assert tens.c.on == true
    assert tens.d.on == false
    assert tens.e.on == false
    assert tens.f.on == true
    assert tens.g.on == true
    assert ones.a.on == true
    assert ones.b.on == false
    assert ones.c.on == true
    assert ones.d.on == true
    assert ones.e.on == false
    assert ones.f.on == true
    assert ones.g.on == true
  end
end
