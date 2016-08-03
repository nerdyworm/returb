defmodule Returb.Router do
  use Returb.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "js"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Returb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/examples", PageController, :examples
    resources "/posts", PostController
    resources "/kittens", KittenController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Returb do
  #   pipe_through :api
  # end
end
