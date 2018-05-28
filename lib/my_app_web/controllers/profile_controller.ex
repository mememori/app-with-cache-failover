defmodule MyAppWeb.ProfileController do
  use MyAppWeb, :controller

  alias MyApp.Customer

  action_fallback(MyAppWeb.FallbackController)

  def index(conn, _params) do
    customer_profiles = Customer.list_customer_profiles()
    render(conn, "index.json", profiles: customer_profiles)
  end

  def create_many(conn, %{"profiles" => profiles_params}) do
    case Customer.create_many_profiles(profiles_params) do
      {:ok, profiles} ->
        conn
        |> put_status(:created)
        |> render("index.json", profiles: profiles)

      {:error, changesets} ->
        conn
        |> put_status(:bad_request)
        |> render("create_many-failed.json", changesets: changesets)
    end
  end

  def delete_all(conn, _) do
    {:ok, _} = Customer.delete_all_profiles()
    send_resp(conn, :no_content, "")
  end
end
