defmodule Returb.PageController do
  use Returb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def examples(conn, _params) do
    render conn, "examples.html"
  end
end
