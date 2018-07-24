defmodule RiskOfRain.ImageTest do
  use RiskOfRain.ModelCase

  alias RiskOfRain.Image

  @valid_attrs %{image: "some image"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Image.changeset(%Image{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Image.changeset(%Image{}, @invalid_attrs)
    refute changeset.valid?
  end
end
