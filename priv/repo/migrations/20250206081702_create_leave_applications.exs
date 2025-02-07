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
end
