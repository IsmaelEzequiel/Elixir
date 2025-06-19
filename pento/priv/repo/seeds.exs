# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pento.Catalog.Product
alias Pento.Repo

now = DateTime.utc_now() |> DateTime.truncate(:second)

products = [
  %{
    name: "Chess X",
    description: "The classic strategy game",
    sku: 5_678_9101,
    unit_price: 10.00,
    inserted_at: now,
    updated_at: now
  },
  %{
    name: "Tic-Tac-Toe X",
    description: "The game of Xs and Os",
    sku: 11_121_3142,
    unit_price: 3.00,
    inserted_at: now,
    updated_at: now
  },
  %{
    name: "Table Tennis X",
    description: "Bat the ball back and forth. Don't miss!",
    sku: 15_222_3243,
    unit_price: 12.00,
    inserted_at: now,
    updated_at: now
  }
]

Product |> Repo.insert_all(products)
