defmodule LeaveApp.LeaveApplicationTest do
  use LeaveApp.DataCase

  alias LeaveApp.LeaveApplication

  describe "leave_applications" do
    alias LeaveApp.LeaveApplication.LeaveForm

    import LeaveApp.LeaveApplicationFixtures

    @invalid_attrs %{name: nil, reason: nil, employee_id: nil, leave_type: nil, start_date: nil, end_date: nil}

    test "list_leave_applications/0 returns all leave_applications" do
      leave_form = leave_form_fixture()
      assert LeaveApplication.list_leave_applications() == [leave_form]
    end

    test "get_leave_form!/1 returns the leave_form with given id" do
      leave_form = leave_form_fixture()
      assert LeaveApplication.get_leave_form!(leave_form.id) == leave_form
    end

    test "create_leave_form/1 with valid data creates a leave_form" do
      valid_attrs = %{name: "some name", reason: "some reason", employee_id: "some employee_id", leave_type: "some leave_type", start_date: ~D[2025-02-05], end_date: ~D[2025-02-05]}

      assert {:ok, %LeaveForm{} = leave_form} = LeaveApplication.create_leave_form(valid_attrs)
      assert leave_form.name == "some name"
      assert leave_form.reason == "some reason"
      assert leave_form.employee_id == "some employee_id"
      assert leave_form.leave_type == "some leave_type"
      assert leave_form.start_date == ~D[2025-02-05]
      assert leave_form.end_date == ~D[2025-02-05]
    end

    test "create_leave_form/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LeaveApplication.create_leave_form(@invalid_attrs)
    end

    test "update_leave_form/2 with valid data updates the leave_form" do
      leave_form = leave_form_fixture()
      update_attrs = %{name: "some updated name", reason: "some updated reason", employee_id: "some updated employee_id", leave_type: "some updated leave_type", start_date: ~D[2025-02-06], end_date: ~D[2025-02-06]}

      assert {:ok, %LeaveForm{} = leave_form} = LeaveApplication.update_leave_form(leave_form, update_attrs)
      assert leave_form.name == "some updated name"
      assert leave_form.reason == "some updated reason"
      assert leave_form.employee_id == "some updated employee_id"
      assert leave_form.leave_type == "some updated leave_type"
      assert leave_form.start_date == ~D[2025-02-06]
      assert leave_form.end_date == ~D[2025-02-06]
    end

    test "update_leave_form/2 with invalid data returns error changeset" do
      leave_form = leave_form_fixture()
      assert {:error, %Ecto.Changeset{}} = LeaveApplication.update_leave_form(leave_form, @invalid_attrs)
      assert leave_form == LeaveApplication.get_leave_form!(leave_form.id)
    end

    test "delete_leave_form/1 deletes the leave_form" do
      leave_form = leave_form_fixture()
      assert {:ok, %LeaveForm{}} = LeaveApplication.delete_leave_form(leave_form)
      assert_raise Ecto.NoResultsError, fn -> LeaveApplication.get_leave_form!(leave_form.id) end
    end

    test "change_leave_form/1 returns a leave_form changeset" do
      leave_form = leave_form_fixture()
      assert %Ecto.Changeset{} = LeaveApplication.change_leave_form(leave_form)
    end
  end
end
