defmodule LeaveAppWeb.LogoutLive do
  use LeaveAppWeb, :live_view
  alias LeaveApp.Accounts

  def mount(_params, _session, socket) do
    # Perform logout action
    Accounts.logout_user()

    # Redirect user to the LOGIN page
    {:ok, redirect(socket, to: "/login")}
  end

  def render(assigns) do
    # Render the logout page
    ~H"""
    <div></div>
    """
  end
end
