defmodule RiskOfRainWeb.ItemController do
  use RiskOfRainWeb, :controller

  alias RiskOfRain.Test
  alias RiskOfRain.Test.Item

  def index(conn, _params) do
    items = Test.list_items()
    render(conn, "index.html", items: items)
  end

  def new(conn, _params) do
    changeset = Test.change_item(%Item{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"item" => item_params}) do
    case Test.create_item(item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: item_path(conn, :show, item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Test.get_item!(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Test.get_item!(id)
    changeset = Test.change_item(item)
    render(conn, "edit.html", item: item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Test.get_item!(id)

    case Test.update_item(item, item_params) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: item_path(conn, :show, item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item = Test.get_item!(id)
    {:ok, _item} = Test.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: item_path(conn, :index))
  end
end
