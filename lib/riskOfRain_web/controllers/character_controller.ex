defmodule RiskOfRainWeb.CharacterController do
  use RiskOfRainWeb, :controller

  alias RiskOfRain.Test
  alias RiskOfRain.Test.Character

  def index(conn, _params) do
    characters = Test.list_characters()
    render(conn, "index.html", characters: characters)
  end

  def new(conn, _params) do
    changeset = Test.change_character(%Character{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"character" => character_params}) do
    case Test.create_character(character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character created successfully.")
        |> redirect(to: character_path(conn, :show, character))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    character = Test.get_character!(id)
    render(conn, "show.html", character: character)
  end

  def edit(conn, %{"id" => id}) do
    character = Test.get_character!(id)
    changeset = Test.change_character(character)
    render(conn, "edit.html", character: character, changeset: changeset)
  end

  def update(conn, %{"id" => id, "character" => character_params}) do
    character_params = Map.put_new(character_params, "abilities", nil)

    character = Test.get_character!(id)

    case Test.update_character(character, character_params) do
      {:ok, character} ->
        conn
        |> put_flash(:info, "Character updated successfully.")
        |> redirect(to: character_path(conn, :show, character))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", character: character, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    character = Test.get_character!(id)
    {:ok, _character} = Test.delete_character(character)

    conn
    |> put_flash(:info, "Character deleted successfully.")
    |> redirect(to: character_path(conn, :index))
  end
end
