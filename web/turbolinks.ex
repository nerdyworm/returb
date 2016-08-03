defmodule Returb.Turbolinks do
  def turbo_redirect(conn, opts) do
    if conn.params["_format"] == "js" do
      to = Keyword.fetch!(opts, :to)
      visit_with_turbolinks(conn, to)
    else
      conn
      |> Phoenix.Controller.redirect(opts)
    end
  end

  defp visit_with_turbolinks(conn, to) do
    script = "Turbolinks.clearCache()\nTurbolinks.visit(#{Poison.encode!(to)})"

    conn
    |> Plug.Conn.put_resp_header("content-type", "text/javascript")
    |> Plug.Conn.send_resp(200, script)
  end
end
