defmodule LeaveAppWeb.Router do
  use LeaveAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LeaveAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # Clear session plug for logout
  pipeline :logout do
    plug :fetch_session  # Add this line to fetch the session
    plug :clear_session
  end

  scope "/", LeaveAppWeb do
    pipe_through [:browser] # Use browser pipeline

    get("/", PageController, :home)

    live "/register", RegisterLive
    live "/login", LoginLive
    live "/home", UsersLive
    live "/leave_applications", LeaveApplicationLive, :index
    live "/employees", EmployeeLive, :index


  end

  # Logout route using the `logout` pipeline
  scope "/", LeaveAppWeb do
    pipe_through [:logout]

    live "/logout", LogoutLive
  end

  defp clear_session(conn, _opts) do
    conn
    |> configure_session(drop: true)  # This will clear the session
    |> redirect(to: "/register")      # Redirect to register page after logout
  end
end
