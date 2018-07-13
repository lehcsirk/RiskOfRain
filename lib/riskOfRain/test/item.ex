defmodule RiskOfRain.Test.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :desc, :string
    field :name, :string
    field :rarity, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :desc, :rarity])
    |> validate_required([:name, :desc, :rarity])
  end
end
