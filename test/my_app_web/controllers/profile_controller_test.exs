defmodule MyAppWeb.ProfileControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Customer
  alias MyApp.Customer.Profile

  @create_attrs %{age: 42, name: "some name"}
  @update_attrs %{age: 43, name: "some updated name"}
  @invalid_attrs %{age: nil, name: nil}

  def fixture(:profile) do
    {:ok, profile} = Customer.create_profile(@create_attrs)
    profile
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customer_profiles", %{conn: conn} do
      conn = get(conn, profile_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_profile(_) do
    profile = fixture(:profile)
    {:ok, profile: profile}
  end
end
