# lib/leave_app/accounts/user.ex

defmodule LeaveApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias LeaveApp.Repo
  alias LeaveApp.Accounts.User

  @type t :: %User{
    email: String.t(),
    password: String.t() | nil,        # Virtual field, can be nil if not provided
    password_hash: String.t(),
    first_name: String.t() | nil,
    last_name: String.t() | nil,
    msisdn: String.t() | nil,
    inserted_at: NaiveDateTime.t() | nil,
    updated_at: NaiveDateTime.t() | nil
  }

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true     # Virtual field for password input
    field :password_hash, :string               # Field to store the hashed password
    field :first_name, :string                  # First name of the user
    field :last_name, :string                   # Last name of the user
    field :msisdn, :string                      # Phone number (mobile number)
    timestamps()                                # Automatically adds created_at and updated_at
  end

  @doc """
  Generates a changeset based on the `user` and `attrs`.

  Validates the required fields and applies password hashing if provided.
  """
  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :password, :first_name, :last_name, :msisdn])  # Added first_name, last_name, msisdn
    |> validate_required([:email, :password, :first_name, :last_name, :msisdn])  # Ensure these fields are present
    |> validate_length(:password, min: 6)  # Password must be at least 6 characters
    |> unique_constraint(:email)  # Ensure the email is unique
    |> put_pass_hash()  # Hash the password before saving
  end

  def create(attrs \\ %{}) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  # This private function is responsible for hashing the password if it exists in the changeset
  defp put_pass_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
    end
  end

  def authenticate_user(email, password) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :user_not_found}
      user ->
        if Bcrypt.verify_pass(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
