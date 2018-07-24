defmodule RiskOfRain.Repo.Migrations.CreateCharacters do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :desc, :string
      add :abilities, {:array, :string}
      # add :avatar, :fileToUpload

      timestamps()
    end

  end
end
