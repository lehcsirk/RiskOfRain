defmodule RiskOfRain.Test do
  @moduledoc """
  The Test context.
  """

  import Ecto.Query, warn: false
  alias RiskOfRain.Repo

  alias RiskOfRain.Test.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{source: %Item{}}

  """
  def change_item(%Item{} = item) do
    Item.changeset(item, %{})
  end

  alias RiskOfRain.Test.Enemy

  @doc """
  Returns the list of enemies.

  ## Examples

      iex> list_enemies()
      [%Enemy{}, ...]

  """
  def list_enemies do
    Repo.all(Enemy)
  end

  @doc """
  Gets a single enemy.

  Raises `Ecto.NoResultsError` if the Enemy does not exist.

  ## Examples

      iex> get_enemy!(123)
      %Enemy{}

      iex> get_enemy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_enemy!(id), do: Repo.get!(Enemy, id)

  @doc """
  Creates a enemy.

  ## Examples

      iex> create_enemy(%{field: value})
      {:ok, %Enemy{}}

      iex> create_enemy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_enemy(attrs \\ %{}) do
    %Enemy{}
    |> Enemy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a enemy.

  ## Examples

      iex> update_enemy(enemy, %{field: new_value})
      {:ok, %Enemy{}}

      iex> update_enemy(enemy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_enemy(%Enemy{} = enemy, attrs) do
    enemy
    |> Enemy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Enemy.

  ## Examples

      iex> delete_enemy(enemy)
      {:ok, %Enemy{}}

      iex> delete_enemy(enemy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_enemy(%Enemy{} = enemy) do
    Repo.delete(enemy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking enemy changes.

  ## Examples

      iex> change_enemy(enemy)
      %Ecto.Changeset{source: %Enemy{}}

  """
  def change_enemy(%Enemy{} = enemy) do
    Enemy.changeset(enemy, %{})
  end

  alias RiskOfRain.Test.Character

  @doc """
  Returns the list of characters.

  ## Examples

      iex> list_characters()
      [%Character{}, ...]

  """
  def list_characters do
    Repo.all(Character)
  end

  @doc """
  Gets a single character.

  Raises `Ecto.NoResultsError` if the Character does not exist.

  ## Examples

      iex> get_character!(123)
      %Character{}

      iex> get_character!(456)
      ** (Ecto.NoResultsError)

  """
  def get_character!(id), do: Repo.get!(Character, id)

  @doc """
  Creates a character.

  ## Examples

      iex> create_character(%{field: value})
      {:ok, %Character{}}

      iex> create_character(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_character(attrs \\ %{}) do
    %Character{}
    |> Character.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a character.

  ## Examples

      iex> update_character(character, %{field: new_value})
      {:ok, %Character{}}

      iex> update_character(character, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_character(%Character{} = character, attrs) do
    character
    |> Character.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Character.

  ## Examples

      iex> delete_character(character)
      {:ok, %Character{}}

      iex> delete_character(character)
      {:error, %Ecto.Changeset{}}

  """
  def delete_character(%Character{} = character) do
    Repo.delete(character)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking character changes.

  ## Examples

      iex> change_character(character)
      %Ecto.Changeset{source: %Character{}}

  """
  def change_character(%Character{} = character) do
    Character.changeset(character, %{})
  end
end
