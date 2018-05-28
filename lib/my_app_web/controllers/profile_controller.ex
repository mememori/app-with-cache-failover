defmodule MyAppWeb.ProfileController do
  use MyAppWeb, :controller

  alias MyApp.Customer
  alias MyApp.Customer.Profile

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    customer_profiles = Customer.list_customer_profiles()
    render(conn, "index.json", customer_profiles: customer_profiles)
  end

  def create(conn, %{"profile" => profile_params}) do
    with {:ok, %Profile{} = profile} <- Customer.create_profile(profile_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", profile_path(conn, :show, profile))
      |> render("show.json", profile: profile)
    end
  end

  def show(conn, %{"id" => id}) do
    profile = Customer.get_profile!(id)
    render(conn, "show.json", profile: profile)
  end

  def update(conn, %{"id" => id, "profile" => profile_params}) do
    profile = Customer.get_profile!(id)

    with {:ok, %Profile{} = profile} <- Customer.update_profile(profile, profile_params) do
      render(conn, "show.json", profile: profile)
    end
  end

  def delete(conn, %{"id" => id}) do
    profile = Customer.get_profile!(id)
    with {:ok, %Profile{}} <- Customer.delete_profile(profile) do
      send_resp(conn, :no_content, "")
    end
  end
end
