defmodule RiskOfRain.TestTest do
  use RiskOfRain.DataCase

  alias RiskOfRain.Test

  describe "items" do
    alias RiskOfRain.Test.Item

    @valid_attrs %{desc: "some desc", name: "some name", rarity: "some rarity"}
    @update_attrs %{desc: "some updated desc", name: "some updated name", rarity: "some updated rarity"}
    @invalid_attrs %{desc: nil, name: nil, rarity: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Test.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Test.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Test.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Test.create_item(@valid_attrs)
      assert item.desc == "some desc"
      assert item.name == "some name"
      assert item.rarity == "some rarity"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Test.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Test.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.desc == "some updated desc"
      assert item.name == "some updated name"
      assert item.rarity == "some updated rarity"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Test.update_item(item, @invalid_attrs)
      assert item == Test.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Test.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Test.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Test.change_item(item)
    end
  end

  describe "enemies" do
    alias RiskOfRain.Test.Enemy

    @valid_attrs %{desc: "some desc", name: "some name", type: "some type"}
    @update_attrs %{desc: "some updated desc", name: "some updated name", type: "some updated type"}
    @invalid_attrs %{desc: nil, name: nil, type: nil}

    def enemy_fixture(attrs \\ %{}) do
      {:ok, enemy} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Test.create_enemy()

      enemy
    end

    test "list_enemies/0 returns all enemies" do
      enemy = enemy_fixture()
      assert Test.list_enemies() == [enemy]
    end

    test "get_enemy!/1 returns the enemy with given id" do
      enemy = enemy_fixture()
      assert Test.get_enemy!(enemy.id) == enemy
    end

    test "create_enemy/1 with valid data creates a enemy" do
      assert {:ok, %Enemy{} = enemy} = Test.create_enemy(@valid_attrs)
      assert enemy.desc == "some desc"
      assert enemy.name == "some name"
      assert enemy.type == "some type"
    end

    test "create_enemy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Test.create_enemy(@invalid_attrs)
    end

    test "update_enemy/2 with valid data updates the enemy" do
      enemy = enemy_fixture()
      assert {:ok, enemy} = Test.update_enemy(enemy, @update_attrs)
      assert %Enemy{} = enemy
      assert enemy.desc == "some updated desc"
      assert enemy.name == "some updated name"
      assert enemy.type == "some updated type"
    end

    test "update_enemy/2 with invalid data returns error changeset" do
      enemy = enemy_fixture()
      assert {:error, %Ecto.Changeset{}} = Test.update_enemy(enemy, @invalid_attrs)
      assert enemy == Test.get_enemy!(enemy.id)
    end

    test "delete_enemy/1 deletes the enemy" do
      enemy = enemy_fixture()
      assert {:ok, %Enemy{}} = Test.delete_enemy(enemy)
      assert_raise Ecto.NoResultsError, fn -> Test.get_enemy!(enemy.id) end
    end

    test "change_enemy/1 returns a enemy changeset" do
      enemy = enemy_fixture()
      assert %Ecto.Changeset{} = Test.change_enemy(enemy)
    end
  end

  describe "characters" do
    alias RiskOfRain.Test.Character

    @valid_attrs %{abilities: [], desc: "some desc", name: "some name"}
    @update_attrs %{abilities: [], desc: "some updated desc", name: "some updated name"}
    @invalid_attrs %{abilities: nil, desc: nil, name: nil}

    def character_fixture(attrs \\ %{}) do
      {:ok, character} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Test.create_character()

      character
    end

    test "list_characters/0 returns all characters" do
      character = character_fixture()
      assert Test.list_characters() == [character]
    end

    test "get_character!/1 returns the character with given id" do
      character = character_fixture()
      assert Test.get_character!(character.id) == character
    end

    test "create_character/1 with valid data creates a character" do
      assert {:ok, %Character{} = character} = Test.create_character(@valid_attrs)
      assert character.abilities == []
      assert character.desc == "some desc"
      assert character.name == "some name"
    end

    test "create_character/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Test.create_character(@invalid_attrs)
    end

    test "update_character/2 with valid data updates the character" do
      character = character_fixture()
      assert {:ok, character} = Test.update_character(character, @update_attrs)
      assert %Character{} = character
      assert character.abilities == []
      assert character.desc == "some updated desc"
      assert character.name == "some updated name"
    end

    test "update_character/2 with invalid data returns error changeset" do
      character = character_fixture()
      assert {:error, %Ecto.Changeset{}} = Test.update_character(character, @invalid_attrs)
      assert character == Test.get_character!(character.id)
    end

    test "delete_character/1 deletes the character" do
      character = character_fixture()
      assert {:ok, %Character{}} = Test.delete_character(character)
      assert_raise Ecto.NoResultsError, fn -> Test.get_character!(character.id) end
    end

    test "change_character/1 returns a character changeset" do
      character = character_fixture()
      assert %Ecto.Changeset{} = Test.change_character(character)
    end
  end
end
