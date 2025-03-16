defmodule HelloSocketsWeb.PageController do
  use HelloSocketsWeb, :controller

  @secret_key Application.compile_env(:hello_sockets, HelloSocketsWeb.Endpoint)[:secret_key_base]

  def home(conn, _params) do
    fake_user_id = 1

    # The home page is often custom made,
    # so skip the default app layout.
    conn
    |> assign(:auth_token, generate_auth_token(conn, fake_user_id))
    |> assign(:user_id, fake_user_id)
    |> render(:home, layout: false)
  end

  defp generate_auth_token(conn, user_id) do
    Phoenix.Token.sign(conn, @secret_key, user_id)
  end

  # API
  def hello_api(conn, %{ "name" => name }) do
    json(conn, %{ name: name, loves: "Lídia Eduarda" })
  end
end
