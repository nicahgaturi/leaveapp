defmodule LeaveApp.Repo.Migrations.CreateLeaveApplications do
  use Ecto.Migration

  def change do
    create table(:leave_applications) do
      add :name, :string
      add :employee_id, :string
      add :leave_type, :string
      add :start_date, :date
      add :end_date, :date
      add :reason, :text

      timestamps(type: :utc_datetime)
    end
  end
  # Add a new column to the leave_applications table to store the status
  def change do
    alter table(:leave_applications) do
      add :status, :string, default: "pending"
    end
  end

end
