defmodule Returb.KittenTest do
  use Returb.ModelCase

  alias Returb.Kitten

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Kitten.changeset(%Kitten{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Kitten.changeset(%Kitten{}, @invalid_attrs)
    refute changeset.valid?
  end
end
