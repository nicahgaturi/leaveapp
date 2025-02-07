defmodule LeaveAppWeb.LoginLive do
  use LeaveAppWeb, :live_view
  alias LeaveApp.Accounts
  alias LeaveApp.Accounts.User
  import Phoenix.HTML
  import Phoenix.HTML.Form

  def render(assigns) do
    ~H"""
    <div class="max-w-md mx-auto p-6 border border-gray-300 rounded-lg shadow-xl bg-white">
      <h2 class="text-3xl text-center font-extrabold text-teal-600 mb-6">Login</h2>

      <.simple_form for={@form} phx-submit="login" phx-change="validate" id="login-form">
        <div class="mb-4">
          <.input field={@form[:email]} type="email" label="Email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>
        <div class="mb-6">
          <.input field={@form[:password]} type="password" label="Password" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>
        <div class="flex justify-center">
          <.button class="w-full py-2 px-4 bg-teal-600 text-white rounded-lg hover:bg-teal-700 focus:ring-4 focus:ring-teal-300">
            Login
          </.button>
        </div>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    form =
       %User{}
       |> User.changeset()
       |> to_form()

    socket =
      socket
      |> assign(form: form)
      |> assign(:current_user, nil)

    {:ok, socket}
  end

  # Handle form validation
  def handle_event("validate", %{"user" => %{"email" => _email, "password" => _password}} = user_params, socket) do
    changeset =
      %User{}
      |> User.changeset(user_params)
      |> Map.put(:action, :insert)
      |> to_form()
      |> IO.inspect(label: "changeset")

    {:noreply,  socket |> assign(form: changeset)}
  end

  # Handle user login attempt
  def handle_event("login", %{"user" => %{"email" => email, "password" => password}}, socket) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:noreply, socket |> assign(:current_user, user) |> redirect(to: "/")}

      {:error, _reason} ->
        changeset =
          %User{}
          |> User.changeset(%{"email" => email, "password" => password})
          |> Map.put(:action, :insert)
          |> to_form()

        {:noreply, assign(socket, form: changeset)}
    end
  end
end
