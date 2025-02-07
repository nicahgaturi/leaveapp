defmodule LeaveAppWeb.LeaveFormLiveTest do
  use LeaveAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import LeaveApp.LeaveApplicationFixtures

  @create_attrs %{name: "some name", reason: "some reason", employee_id: "some employee_id", leave_type: "some leave_type", start_date: "2025-02-05", end_date: "2025-02-05"}
  @update_attrs %{name: "some updated name", reason: "some updated reason", employee_id: "some updated employee_id", leave_type: "some updated leave_type", start_date: "2025-02-06", end_date: "2025-02-06"}
  @invalid_attrs %{name: nil, reason: nil, employee_id: nil, leave_type: nil, start_date: nil, end_date: nil}

  defp create_leave_form(_) do
    leave_form = leave_form_fixture()
    %{leave_form: leave_form}
  end

  describe "Index" do
    setup [:create_leave_form]

    test "lists all leave_applications", %{conn: conn, leave_form: leave_form} do
      {:ok, _index_live, html} = live(conn, ~p"/leave_applications")

      assert html =~ "Listing Leave applications"
      assert html =~ leave_form.name
    end

    test "saves new leave_form", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_applications")

      assert index_live |> element("a", "New Leave form") |> render_click() =~
               "New Leave form"

      assert_patch(index_live, ~p"/leave_applications/new")

      assert index_live
             |> form("#leave_form-form", leave_form: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#leave_form-form", leave_form: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/leave_applications")

      html = render(index_live)
      assert html =~ "Leave form created successfully"
      assert html =~ "some name"
    end

    test "updates leave_form in listing", %{conn: conn, leave_form: leave_form} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_applications")

      assert index_live |> element("#leave_applications-#{leave_form.id} a", "Edit") |> render_click() =~
               "Edit Leave form"

      assert_patch(index_live, ~p"/leave_applications/#{leave_form}/edit")

      assert index_live
             |> form("#leave_form-form", leave_form: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#leave_form-form", leave_form: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/leave_applications")

      html = render(index_live)
      assert html =~ "Leave form updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes leave_form in listing", %{conn: conn, leave_form: leave_form} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_applications")

      assert index_live |> element("#leave_applications-#{leave_form.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#leave_applications-#{leave_form.id}")
    end
  end

  describe "Show" do
    setup [:create_leave_form]

    test "displays leave_form", %{conn: conn, leave_form: leave_form} do
      {:ok, _show_live, html} = live(conn, ~p"/leave_applications/#{leave_form}")

      assert html =~ "Show Leave form"
      assert html =~ leave_form.name
    end

    test "updates leave_form within modal", %{conn: conn, leave_form: leave_form} do
      {:ok, show_live, _html} = live(conn, ~p"/leave_applications/#{leave_form}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Leave form"

      assert_patch(show_live, ~p"/leave_applications/#{leave_form}/show/edit")

      assert show_live
             |> form("#leave_form-form", leave_form: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#leave_form-form", leave_form: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/leave_applications/#{leave_form}")

      html = render(show_live)
      assert html =~ "Leave form updated successfully"
      assert html =~ "some updated name"
    end
  end
end
