defmodule LeaveApp.LeaveApplicationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LeaveApp.LeaveApplication` context.
  """

  @doc """
  Generate a leave_form.
  """
  def leave_form_fixture(attrs \\ %{}) do
    {:ok, leave_form} =
      attrs
      |> Enum.into(%{
        employee_id: "some employee_id",
        end_date: ~D[2025-02-05],
        leave_type: "some leave_type",
        name: "some name",
        reason: "some reason",
        start_date: ~D[2025-02-05]
      })
      |> LeaveApp.LeaveApplication.create_leave_form()

    leave_form
  end
end
