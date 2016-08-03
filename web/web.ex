defmodule Returb.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Returb.Web, :controller
      use Returb.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Returb.Repo
      import Ecto
      import Ecto.Query

      import Returb.Router.Helpers
      import Returb.Gettext
      import Returb.Turbolinks
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Returb.Router.Helpers
      import Returb.ErrorHelpers
      import Returb.Gettext

      def set_state(props) do
        [
          Phoenix.HTML.Tag.content_tag(:div, "", [
            class: "turbo-react-state",
            "data-states": Poison.encode!(props)
          ]),
      ]
      end

      def mount(name, props \\ %{}) do
        props = Poison.encode!(props)

        [
          Phoenix.HTML.Tag.content_tag(:div, "", [
            class: "turbo-react-component",
            "data-component": name,
            "data-props": props
          ]),
        ]
      end
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Returb.Repo
      import Ecto
      import Ecto.Query
      import Returb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
