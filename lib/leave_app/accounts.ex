defmodule LeaveApp.Accounts do
  alias LeaveApp.Repo
  alias LeaveApp.Accounts.User
  import Bcrypt


  # Register a new user
  def register_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # Authenticate the user
  def authenticate_user(email, password) do
    user = Repo.get_by(User, email: email)

    if user && Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end

  # Log the user out by clearing the session
  def logout_user() do
    #  clear the session

    :ok
  end
end
