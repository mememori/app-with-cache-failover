defmodule MyAppWeb.ProfileView do
  use MyAppWeb, :view

  alias MyAppWeb.ChangesetView
  alias MyAppWeb.ProfileView

  def render("index.json", %{profiles: customer_profiles}) do
    %{data: render_many(customer_profiles, ProfileView, "profile.json")}
  end

  def render("create_many-failed.json", %{changesets: changesets}) do
    %{failed: render_many(changesets, ChangesetView, "error.json")}
  end

  def render("profile.json", %{profile: profile}) do
    %{
      id: profile.id,
      name: profile.name,
      age: profile.age
    }
  end
end
