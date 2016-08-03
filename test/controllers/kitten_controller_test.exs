defmodule Returb.KittenControllerTest do
  use Returb.ConnCase

  alias Returb.Kitten
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, kitten_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing kittens"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, kitten_path(conn, :new)
    assert html_response(conn, 200) =~ "New kitten"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, kitten_path(conn, :create), kitten: @valid_attrs
    assert redirected_to(conn) == kitten_path(conn, :index)
    assert Repo.get_by(Kitten, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, kitten_path(conn, :create), kitten: @invalid_attrs
    assert html_response(conn, 200) =~ "New kitten"
  end

  test "shows chosen resource", %{conn: conn} do
    kitten = Repo.insert! %Kitten{}
    conn = get conn, kitten_path(conn, :show, kitten)
    assert html_response(conn, 200) =~ "Show kitten"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, kitten_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    kitten = Repo.insert! %Kitten{}
    conn = get conn, kitten_path(conn, :edit, kitten)
    assert html_response(conn, 200) =~ "Edit kitten"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    kitten = Repo.insert! %Kitten{}
    conn = put conn, kitten_path(conn, :update, kitten), kitten: @valid_attrs
    assert redirected_to(conn) == kitten_path(conn, :show, kitten)
    assert Repo.get_by(Kitten, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    kitten = Repo.insert! %Kitten{}
    conn = put conn, kitten_path(conn, :update, kitten), kitten: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit kitten"
  end

  test "deletes chosen resource", %{conn: conn} do
    kitten = Repo.insert! %Kitten{}
    conn = delete conn, kitten_path(conn, :delete, kitten)
    assert redirected_to(conn) == kitten_path(conn, :index)
    refute Repo.get(Kitten, kitten.id)
  end
end
