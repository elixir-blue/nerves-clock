defmodule FWTest do
  use ExUnit.Case
  doctest FW

  test "greets the world" do
    assert FW.hello() == :world
  end
end
