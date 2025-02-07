defmodule LeaveAppWeb.Auth  do

  use Phoenix.LiveView
  import Logger

  def on_mount(:default, _params, session, socket) do

    session
    |> IO.inspect(label: "session")
    socket
    |> IO.inspect(label: "socket")


    {:cont, socket}

  end
end
