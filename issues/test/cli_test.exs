defmodule CLITest do
  use ExUnit.Case
  doctest(Issues)

  import Issues.CLI, only: [ parse_args: 1, sort_into_descending_order: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    # Another way to return the argv below
    # assert parse_args(OptionParser.to_argv(h: "anything")) == :help
    assert parse_args(["--h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "13"]) == { "user", "project", 13 }
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

  test "sort descending orders the correct way" do
    list =
      create_fake_data_list(["c", "a", "b", "e", "d"])
        |> sort_into_descending_order()
        |> Enum.map(&(&1["created_at"]))

    assert list == ~w{ e d c b a }
  end

  defp create_fake_data_list(values) do
    for v <- values, do: %{ "created_at" => v }
  end
end
