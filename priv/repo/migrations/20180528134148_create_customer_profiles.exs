defmodule MyApp.Repo.Migrations.CreateCustomerProfiles do
  use Ecto.Migration

  def change do
    create table(:customer_profiles, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:age, :integer)

      timestamps()
    end
  end
end
