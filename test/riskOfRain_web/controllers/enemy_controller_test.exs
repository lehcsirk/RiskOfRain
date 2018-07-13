defmodule RiskOfRainWeb.EnemyControllerTest do
  use RiskOfRainWeb.ConnCase

  alias RiskOfRain.Test

  @create_attrs %{desc: "some desc", name: "some name", type: "some type"}
  @update_attrs %{desc: "some updated desc", name: "some updated name", type: "some updated type"}
  @invalid_attrs %{desc: nil, name: nil, type: nil}

  def fixture(:enemy) do
    {:ok, enemy} = Test.create_enemy(@create_attrs)
    enemy
  end

  describe "index" do
    test "lists all enemies", %{conn: conn} do
      conn = get conn, enemy_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Enemies"
    end
  end

  describe "new enemy" do
    test "renders form", %{conn: conn} do
      conn = get conn, enemy_path(conn, :new)
      assert html_response(conn, 200) =~ "New Enemy"
    end
  end

  describe "create enemy" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, enemy_path(conn, :create), enemy: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == enemy_path(conn, :show, id)

      conn = get conn, enemy_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Enemy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, enemy_path(conn, :create), enemy: @invalid_attrs
      assert html_response(conn, 200) =~ "New Enemy"
    end
  end

  describe "edit enemy" do
    setup [:create_enemy]

    test "renders form for editing chosen enemy", %{conn: conn, enemy: enemy} do
      conn = get conn, enemy_path(conn, :edit, enemy)
      assert html_response(conn, 200) =~ "Edit Enemy"
    end
  end

  describe "update enemy" do
    setup [:create_enemy]

    test "redirects when data is valid", %{conn: conn, enemy: enemy} do
      conn = put conn, enemy_path(conn, :update, enemy), enemy: @update_attrs
      assert redirected_to(conn) == enemy_path(conn, :show, enemy)

      conn = get conn, enemy_path(conn, :show, enemy)
      assert html_response(conn, 200) =~ "some updated desc"
    end

    test "renders errors when data is invalid", %{conn: conn, enemy: enemy} do
      conn = put conn, enemy_path(conn, :update, enemy), enemy: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Enemy"
    end
  end

  describe "delete enemy" do
    setup [:create_enemy]

    test "deletes chosen enemy", %{conn: conn, enemy: enemy} do
      conn = delete conn, enemy_path(conn, :delete, enemy)
      assert redirected_to(conn) == enemy_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, enemy_path(conn, :show, enemy)
      end
    end
  end

  defp create_enemy(_) do
    enemy = fixture(:enemy)
    {:ok, enemy: enemy}
  end
end
