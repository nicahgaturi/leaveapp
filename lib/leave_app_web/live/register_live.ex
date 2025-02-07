defmodule LeaveAppWeb.RegisterLive do
  use LeaveAppWeb, :live_view
  alias LeaveApp.Accounts
  alias LeaveApp.Accounts.User

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto p-8 border border-gray-300 rounded-lg shadow-lg bg-white">
      <h1 class="text-3xl text-center font-extrabold text-teal-600 mb-8">Register</h1>

      <.simple_form for={@form} phx-change="validate" phx-submit="submit" id="register-form">
        <!-- Email Input -->
        <div class="mb-4">
          <.input field={@form[:email]} type="email" label="Email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>

        <!-- Password Input -->
        <div class="mb-4">
          <.input field={@form[:password]} type="password" label="Password" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>

        <!-- First Name Input -->
        <div class="mb-4">
          <.input field={@form[:first_name]} type="text" label="First Name" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>

        <!-- Last Name Input -->
        <div class="mb-4">
          <.input field={@form[:last_name]} type="text" label="Last Name" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>

        <!-- Phone Number Input -->
        <div class="mb-6">
          <.input field={@form[:msisdn]} type="text" label="Phone Number" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-500" />
        </div>

        <!-- Submit Button -->
        <div class="mb-6">
          <.button phx-disable-with="Submitting..." class="w-full py-2 px-4 bg-teal-600 text-white rounded-lg hover:bg-teal-700 focus:ring-4 focus:ring-teal-300">
            Submit
          </.button>
        </div>
      </.simple_form>

      <!-- Link to Login -->
      <div class="flex flex-row items-center justify-center mt-6">
        <span class="text-gray-600">Already have an account?</span>
        <div class="ml-2 border w-fit p-2 border-gray-300 bg-teal-200 hover:bg-teal-600 rounded-md shadow-md">
          <.link navigate={~p"/login"} class="text-teal-700 hover:text-white">
            Login
          </.link>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    form =
      %User{}
      |> Ecto.Changeset.change()
      |> to_form()

    socket =
      socket
      |> assign(form: form)

    {:ok, socket}
  end

  # Handle form validation
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> User.changeset(user_params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, form: changeset)}
  end

  # Handle user registration
  def handle_event("submit", %{"user" => user_params}, socket) do
    case User.create(user_params) do
      {:ok, user} ->
        socket =
          socket
          |> put_flash(:info, "Welcome #{user.email}")
          |> redirect(to: "/login")
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: changeset |> to_form())}
    end
  end
end
