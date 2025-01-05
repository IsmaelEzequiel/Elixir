defmodule HelloSocketsWeb.AuthSocketTest do
  use HelloSocketsWeb.ChannelCase
  import ExUnit.CaptureLog
  alias HelloSocketsWeb.AuthSocket
  alias HelloSocketsWeb.AuthChannel

  @secret_key_base Application.compile_env(:hello_sockets, HelloSocketsWeb.Endpoint)[:secret_key_base]

  defp generate_token(id, opts \\ []) do
    salt = Keyword.get(opts, :salt, "salt identifier")
    Phoenix.Token.sign(HelloSocketsWeb.Endpoint, salt, id)
  end

   describe "connect/3 success" do
    test "can't be connected with a wrong salt" do
      params = %{"token" => generate_token(1, salt: "wrong salt")}

      assert capture_log(fn ->
        assert :error = connect(AuthSocket, params)
      end)
    end

    test "can't be connected without token" do
      params = %{}

      assert capture_log(fn ->
        assert :error = connect(AuthSocket, params)
      end)
    end

    test "can be connected to with a valid token" do
      assert {:ok, %Phoenix.Socket{}} =
               connect(AuthSocket, %{"token" => generate_token(1, salt: @secret_key_base)})

      assert {:ok, %Phoenix.Socket{}} =
               connect(AuthSocket, %{"token" => generate_token(2, salt: @secret_key_base)})
    end
  end

  describe "id/3" do
    test "an identifier is based on connected ID" do
      assert {:ok, socket} =
        connect(AuthSocket, %{"token" => generate_token(1, salt: @secret_key_base)})

      assert AuthSocket.id(socket) == "user_socket:#{1}"

      assert {:ok, socket} =
        connect(AuthSocket, %{"token" => generate_token(2, salt: @secret_key_base)})

      assert AuthSocket.id(socket) == "user_socket:#{2}"
    end
  end
end
