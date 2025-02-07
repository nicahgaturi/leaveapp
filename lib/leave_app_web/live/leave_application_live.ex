defmodule LeaveAppWeb.LeaveApplicationLive do
  use LeaveAppWeb, :live_view

  alias LeaveApp.LeaveApplications
  alias LeaveApp.LeaveApplications.LeaveApplication

  def render(assigns) do
    ~L"""
    <div class="max-w-lg mx-auto p-6 bg-white rounded-lg shadow-md">
      <h1 class="text-3xl font-semibold text-center text-teal-600 mb-6">Apply for Leave</h1>
      <form phx-submit="save_leave_application" class="space-y-4">
        <div>
          <label for="name" class="block text-gray-700 font-medium">Name</label>
          <input type="text" name="name" value="<%= @name %>" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300"/>
        </div>

        <div>
          <label for="employee_id" class="block text-gray-700 font-medium">Employee ID</label>
          <input type="text" name="employee_id" value="<%= @employee_id %>" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300"/>
        </div>

        <div>
          <label for="leave_type" class="block text-gray-700 font-medium">Leave Type</label>
          <select name="leave_type" value="<%= @leave_type %>" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300">
            <option value="sick">Sick</option>
            <option value="vacation">Vacation</option>
            <option value="personal">Personal</option>
          </select>
        </div>

        <div>
          <label for="start_date" class="block text-gray-700 font-medium">Start Date</label>
          <input type="date" name="start_date" value="<%= @start_date %>" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300"/>
        </div>

        <div>
          <label for="end_date" class="block text-gray-700 font-medium">End Date</label>
          <input type="date" name="end_date" value="<%= @end_date %>" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300"/>
        </div>

        <div>
          <label for="reason" class="block text-gray-700 font-medium">Reason</label>
          <textarea name="reason" required class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-teal-300"><%= @reason %></textarea>
        </div>

        <div>
          <button type="submit"
                  class="w-full bg-teal-600 text-white py-2 rounded-md hover:bg-teal-700 focus:ring-4 focus:ring-teal-300"
                  <%= if @form_submitted, do: "disabled", else: "" %>>
            Submit Leave Application
          </button>
        </div>
      </form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, name: "", employee_id: "", leave_type: "", start_date: "", end_date: "", reason: "", form_submitted: false)}
  end

  def handle_event("save_leave_application", %{"name" => name, "employee_id" => employee_id, "leave_type" => leave_type, "start_date" => start_date, "end_date" => end_date, "reason" => reason}, socket) do
    case LeaveApplications.create_leave_application(%{
      name: name,
      employee_id: employee_id,
      leave_type: leave_type,
      start_date: start_date,
      end_date: end_date,
      reason: reason
    }) do
      {:ok, _leave_application} ->
        {:noreply, socket
          |> put_flash(:info, "Leave application submitted successfully.")
          |> assign(:form_submitted, true)}  # Disable the button after submission

      {:error, changeset} ->
        {:noreply, socket
          |> assign(:changeset, changeset)
          |> put_flash(:error, "Error submitting leave application.")}
    end
  end
end
