defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :unit_price, :float
    field :sku, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, greater_than: 0.0)
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
  end

  def price_decrease_drop_changeset(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_drop_price
  end

  @spec validate_drop_price(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def validate_drop_price(product) do
    current_price = product.data.unit_price
    new_price = get_change(product, :unit_price)

    if new_price >= current_price do
      IO.puts new_price
      IO.puts current_price
      add_error(product, :unit_price, "must be lower than the current price")
    else
      product
    end
  end
end
