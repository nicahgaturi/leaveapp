defmodule LeaveApp.Repo do
  use Ecto.Repo,
    otp_app: :leave_app,
    adapter: Ecto.Adapters.Postgres
end
