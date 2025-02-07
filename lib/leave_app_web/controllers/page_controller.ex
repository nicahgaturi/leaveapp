
defmodule LeaveAppWeb.PageController do
  use LeaveAppWeb, :controller

  def home(conn, _params) do
    logged_in = get_session(conn, :user_id) != nil
    render(conn, "home.html", logged_in: logged_in, layout: false)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)  # Save user ID in session
        |> redirect(to: "/")

      {:error, _reason} ->
        # Handle login error (e.g., show an error message)
        render(conn, "login.html", error: "Invalid credentials")
    end
  end
end
