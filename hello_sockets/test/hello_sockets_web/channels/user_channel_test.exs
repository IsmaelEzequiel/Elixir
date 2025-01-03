defmodule HelloSocketsWeb.UserChannelTest do
  use HelloSocketsWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      HelloSocketsWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(HelloSocketsWeb.UserChannel, "user")

    %{socket: socket}
  end

  test "shout broadcasts to user:lobby", %{socket: socket} do
    push(socket, "shout", %{"hello" => "all"})
    assert_broadcast "shout", %{"hello" => "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end
