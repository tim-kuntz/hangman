defmodule CpuClientTest do
  use ExUnit.Case
  doctest CpuClient

  test "greets the world" do
    assert CpuClient.hello() == :world
  end
end
