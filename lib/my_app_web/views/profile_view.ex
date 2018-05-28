defmodule MyAppWeb.ProfileView do
  use MyAppWeb, :view
  alias MyAppWeb.ProfileView

  def render("index.json", %{customer_profiles: customer_profiles}) do
    %{data: render_many(customer_profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{id: profile.id,
      name: profile.name,
      age: profile.age}
  end
end
