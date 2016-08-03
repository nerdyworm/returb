defmodule Returb.KittenController do
  use Returb.Web, :controller

  alias Returb.Kitten

  def index(conn, _params) do
    kittens = Repo.all(Kitten)
    render(conn, "index.html", kittens: kittens)
  end

  def new(conn, _params) do
    changeset = Kitten.changeset(%Kitten{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kitten" => kitten_params}) do
    changeset = Kitten.changeset(%Kitten{}, kitten_params)

    case Repo.insert(changeset) do
      {:ok, _kitten} ->
        conn
        |> put_flash(:info, "Kitten created successfully.")
        |> turbo_redirect(to: kitten_path(conn, :index))
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kitten = Repo.get!(Kitten, id)
    render(conn, "show.html", kitten: kitten)
  end

  def edit(conn, %{"id" => id}) do
    kitten = Repo.get!(Kitten, id)
    changeset = Kitten.changeset(kitten)
    render(conn, "edit.html", kitten: kitten, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kitten" => kitten_params}) do
    kitten = Repo.get!(Kitten, id)
    changeset = Kitten.changeset(kitten, kitten_params)

    case Repo.update(changeset) do
      {:ok, kitten} ->
        conn
        |> put_flash(:info, "Kitten updated successfully.")
        |> turbo_redirect(to: kitten_path(conn, :show, kitten))
      {:error, changeset} ->
        render(conn, :edit, kitten: kitten, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kitten = Repo.get!(Kitten, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(kitten)

    conn
    |> put_flash(:info, "Kitten deleted successfully.")
    |> turbo_redirect(to: kitten_path(conn, :index))
  end
end
