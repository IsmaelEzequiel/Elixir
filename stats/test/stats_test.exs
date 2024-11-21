defmodule StatsTest do
  use ExUnit.Case
  doctest Stats

  import Stats, only: [ sum: 1, count: 1, average: 1 ]

  describe "Stats on lists of ints" do
    setup do
      [
        list:    [1, 3, 5, 7, 9, 11],
        sum:     36,
        count:   6
      ]
    end

    test "get sum", fixture do
      assert sum(fixture.list) == fixture.sum
    end

    test "get counts", fixture do
      assert count(fixture.list) == fixture.count
    end

    test "get average", fixture do
      assert average(fixture.list) == fixture.count
    end
  end
end
