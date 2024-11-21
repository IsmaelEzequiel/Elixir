defmodule StatsPropertyTest do
  require Logger

  use ExUnit.Case
  use ExUnitProperties

  describe "Stats on lists of ints" do
    property("Single element list are their own sum") do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    property("count non negative") do
      check all list <- list_of(integer()) do
        assert Stats.count(list) >= 0
      end
    end

    property "sum equals average times count" do
      check all l <- list_of(integer(), min_length: 5) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l)*Stats.average(l),
          1
        )
      end
    end
  end
end
