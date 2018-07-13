defmodule RiskOfRainWeb.EnemyController do
  use RiskOfRainWeb, :controller

  alias RiskOfRain.Test
  alias RiskOfRain.Test.Enemy

  def index(conn, _params) do
    enemies = Test.list_enemies()
    render(conn, "index.html", enemies: enemies)
  end

  def new(conn, _params) do
    changeset = Test.change_enemy(%Enemy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"enemy" => enemy_params}) do
    case Test.create_enemy(enemy_params) do
      {:ok, enemy} ->
        conn
        |> put_flash(:info, "Enemy created successfully.")
        |> redirect(to: enemy_path(conn, :show, enemy))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    enemy = Test.get_enemy!(id)
    render(conn, "show.html", enemy: enemy)
  end

  def edit(conn, %{"id" => id}) do
    enemy = Test.get_enemy!(id)
    changeset = Test.change_enemy(enemy)
    render(conn, "edit.html", enemy: enemy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "enemy" => enemy_params}) do
    enemy = Test.get_enemy!(id)

    case Test.update_enemy(enemy, enemy_params) do
      {:ok, enemy} ->
        conn
        |> put_flash(:info, "Enemy updated successfully.")
        |> redirect(to: enemy_path(conn, :show, enemy))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", enemy: enemy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    enemy = Test.get_enemy!(id)
    {:ok, _enemy} = Test.delete_enemy(enemy)

    conn
    |> put_flash(:info, "Enemy deleted successfully.")
    |> redirect(to: enemy_path(conn, :index))
  end
end
