defmodule RiskOfRain.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :desc, :string
      add :rarity, :string

      timestamps()
    end

  end
end
