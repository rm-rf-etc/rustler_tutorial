defmodule MyProjTest do
  use ExUnit.Case
  doctest MyProj

  test "greets the world" do
    assert MyProj.hello() == :world
  end
end
