defmodule LeaveApp.LeaveApplications.LeaveApplication do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leave_applications" do
    field :name, :string
    field :employee_id, :string
    field :leave_type, :string
    field :start_date, :date
    field :end_date, :date
    field :reason, :string


    timestamps()
  end

  def changeset(leave_application, attrs) do
    leave_application
    |> cast(attrs, [:name, :employee_id, :leave_type, :start_date, :end_date, :reason])
    |> validate_required([:name, :employee_id, :leave_type, :start_date, :end_date, :reason])
    |> validate_date_range()
  end

  # Custom validation to ensure start_date is before end_date
  defp validate_date_range(changeset) do
    start_date = get_field(changeset, :start_date)
    end_date = get_field(changeset, :end_date)

    if start_date && end_date && Date.compare(start_date, end_date) == :gt do
      add_error(changeset, :end_date, "must be after the start date")
    else
      changeset
    end
  end
end
