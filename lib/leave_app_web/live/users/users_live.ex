defmodule LeaveAppWeb.UsersLive do
  use LeaveAppWeb, :live_view
  alias LeaveApp.Accounts
  alias LeaveAppWeb.Router.Helpers, as: Routes
  import Phoenix.LiveView.Helpers  # For live helpers like `live_redirect`

  def render(assigns) do
    ~H"""
    <div class="container">
      <h1>Welcome to Leave App</h1>

      <%= if @current_user do %>
        <p>Welcome, <%= @current_user.email %>!</p>
        <p>Your role: <%= @current_user.role %></p>

        <%= if @current_user.role == "admin" do %>
          <p>You are an admin, <a href="#">Manage Users</a></p>
        <% end %>

        <.link  href={~p"/logout"} > Logout </.link>

      <% else %>
        <p>You are not logged in.</p>
        <%= live_redirect "Login", to: Routes.live_path(@socket, LeaveAppWeb.LoginLive) %>
        <%= live_redirect "Register", to: Routes.live_path(@socket, LeaveAppWeb.RegisterLive) %>
      <% end %>
    </div>
    """
  end

  def mount(_params, session, socket) do
    current_user = get_current_user(session)
    {:ok, assign(socket, current_user: current_user)}
  end

  # Function to get the current user based on the session token
  defp get_current_user(session) do
    case session["user_token"] do
      nil -> nil  # If there is no token, no user is logged in
      token -> Accounts.get_user_by_token(token)  # Retrieve user by token (adjust for your actual function)
    end
  end

  def handle_event("logout", _params, socket) do
    {}
  end
end
