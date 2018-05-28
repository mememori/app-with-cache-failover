defmodule MyApp.Customer.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customer_profiles" do
    field(:age, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
