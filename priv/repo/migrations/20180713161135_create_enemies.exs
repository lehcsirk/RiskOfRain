defmodule RiskOfRain.Repo.Migrations.CreateEnemies do
  use Ecto.Migration

  def change do
    create table(:enemies) do
      add :name, :string
      add :desc, :string
      add :type, :string

      timestamps()
    end

  end
end
