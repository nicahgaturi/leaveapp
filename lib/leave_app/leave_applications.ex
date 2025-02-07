defmodule LeaveApp.LeaveApplications do
  import Ecto.Query, warn: false
  alias LeaveApp.Repo
  alias LeaveApp.LeaveApplications.LeaveApplication

  # Create leave application
  def create_leave_application(attrs) do
    %LeaveApplication{}
    |> LeaveApplication.changeset(attrs)
    |> Repo.insert()
  end

  # Get all leave applications
  def list_leave_applications do
    Repo.all(LeaveApplication)
  end
end
