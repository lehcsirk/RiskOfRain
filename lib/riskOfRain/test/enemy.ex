defmodule RiskOfRain.Test.Enemy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "enemies" do
    field :desc, :string
    field :name, :string
    field :type, :string
    has_one :avatar, :fileToUpload
    timestamps()
  end

  @doc false
  def changeset(enemy, attrs) do
    enemy
    |> cast(attrs, [:name, :desc, :type])
    |> validate_required([:name, :desc, :type])
  end
end
