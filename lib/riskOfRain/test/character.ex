defmodule RiskOfRain.Test.Character do
  use Ecto.Schema
  import Ecto.Changeset


  schema "characters" do
    field :abilities, {:array, :string}
    field :desc, :string
    field :name, :string
    has_one :avatar, :fileToUpload
    timestamps()
  end

  @doc false
  def changeset(character, %{"abilities" => nil} = attrs) do
   changeset(character, %{attrs | "abilities" => []})
  end

  def changeset(character, attrs) do
    character
    |> cast(attrs, [:name, :desc, :abilities])
    |> validate_required([:name, :desc, :abilities])
    |> validate_length(:abilities, max: 4)
  end
end
