defmodule MyAppWeb.ProfileControllerTest do
  use MyAppWeb.ConnCase

  alias MyApp.Customer

  @create_attrs %{age: 42, name: "some name"}

  def fixture(:profile) do
    {:ok, profile} = Customer.create_profile(@create_attrs)
    profile
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customer_profiles", %{conn: conn} do
      fixture(:profile)
      fixture(:profile)

      conn = get(conn, profile_path(conn, :index))
      assert [%{}, %{}] = json_response(conn, 200)["data"]
    end
  end

  describe "create_many" do
    test "creates several profiles at once", %{conn: conn} do
      params = %{
        profiles: [
          %{name: "Shinji do Robo", age: 17},
          %{name: "Astrolabio Sideral", age: 100}
        ]
      }

      conn = post(conn, profile_path(conn, :create_many), params)
      assert %{"data" => [p1, p2]} = json_response(conn, 201)

      assert %{"name" => _, "age" => _, "id" => _} = p1
      assert %{"name" => _, "age" => _, "id" => _} = p2

      assert p1["name"] == "Shinji do Robo"
      assert p1["age"] == 17
      assert p2["name"] == "Astrolabio Sideral"
      assert p2["age"] == 100

      assert [_, _] = Customer.list_customer_profiles()
    end

    test "returns failed entries only when provided with invalid input", %{conn: conn} do
      params = %{
        profiles: [
          %{name: "Shinji do Robo", age: 17},
          %{name: "", age: -1},
          %{name: "Astrolabio Sideral", age: 100},
          %{name: "Highlander"}
        ]
      }

      conn = post(conn, profile_path(conn, :create_many), params)
      assert %{"failed" => [p1, p2]} = json_response(conn, 400)

      assert %{"errors" => _} = p1
      assert %{"errors" => _} = p2

      assert "name" in Map.keys(p1["errors"])
      assert "age" in Map.keys(p1["errors"])

      refute "name" in Map.keys(p2["errors"])
      assert "age" in Map.keys(p2["errors"])

      assert Customer.list_customer_profiles() == []
    end
  end

  describe "delete_all" do
    test "removes all existing profiles", %{conn: conn} do
      fixture(:profile)
      fixture(:profile)

      assert [_, _] = Customer.list_customer_profiles()
      conn = delete(conn, profile_path(conn, :delete_all))

      # No content
      assert response(conn, 204)

      assert [] = Customer.list_customer_profiles()
    end
  end
end
