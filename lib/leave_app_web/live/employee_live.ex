defmodule LeaveAppWeb.EmployeeLive do
  use LeaveAppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <!-- Header Section -->
      <header class="bg-teal-600 text-white py-4">
        <div class="container mx-auto text-center">
          <h1 class="text-3xl font-semibold">Employee Profile</h1>
        </div>
      </header>

      <!-- Content Section -->
      <div class="container mx-auto mt-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <!-- Personal Information Section -->
          <div class="bg-white p-4 rounded shadow">
            <h2 class="text-lg font-semibold mb-2">Personal Information</h2>
            <p>Name: Neo Saturi</p>
            <p>Email: neo@gmail.com</p>
            <p>Role: Employee</p>
          </div>
        </div>

        <!-- Leave History Section  -->
        <div class="bg-gray-50 p-6 rounded-lg shadow-lg mt-6 border border-gray-200">
          <h2 class="text-xl font-semibold text-teal-600 mb-4">Leave History</h2>
          <table class="min-w-full table-auto border-collapse">
            <thead>
              <tr class="bg-teal-100">
                <th class="py-2 px-4 text-left border-b text-teal-600">Leave Type</th>
                <th class="py-2 px-4 text-left border-b text-teal-600">Start Date</th>
                <th class="py-2 px-4 text-left border-b text-teal-600">End Date</th>
                <th class="py-2 px-4 text-left border-b text-teal-600">Status</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="py-2 px-4 border-b">Annual Leave</td>
                <td class="py-2 px-4 border-b">01/01/2023</td>
                <td class="py-2 px-4 border-b">31/12/2023</td>
                <td class="py-2 px-4 border-b">Approved</td>
              </tr>

            </tbody>
          </table>
        </div>

        <!-- Apply for Leave Button -->
        <div class="mt-6 text-center">
          <a href="/leave_applications" class="inline-block bg-teal-600 text-white py-2 px-4 rounded hover:bg-teal-700 transition duration-300">
            Apply for Leave
          </a>
        </div>
      </div>
    </div>
    """
  end
end
