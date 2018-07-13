defmodule RiskOfRain.Test.Character do
  use Ecto.Schema
  import Ecto.Changeset


  schema "characters" do
    field :abilities, {:array, :string}
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :desc, :abilities])
    |> validate_required([:name, :desc, :abilities])
  end
end
