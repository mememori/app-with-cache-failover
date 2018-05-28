defmodule MyApp.Customer.Profile do
  @moduledoc """
    Represents the profile of an customer.

    Every customer has personal data like their name, age etc. This represents
    such data and thus an individual person.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type id :: String.t()
  @type t :: %__MODULE__{
          id: id,
          name: String.t(),
          age: 0..130,
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
  @type changeset :: changeset(Ecto.Changeset.action())
  @type changeset(action) :: %Ecto.Changeset{action: action, data: %__MODULE__{}}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customer_profiles" do
    field(:name, :string)
    field(:age, :integer)

    timestamps()
  end

  @spec create(map) :: changeset(:insert)
  @doc """
  Prepares a changeset to _create_ a Profile.

  ## Params

    - `name` - The name of the customer.
    - `age` - The age of the customer.

  ## Examples

      iex> changeset = MyApp.Customer.Profile.create(%{
      ...>   name: "Arnesto do Bar",
      ...>   age: 21
      ...> })
      iex> changeset.action
      :insert
      iex> changeset.valid?
      true

      iex> changeset = MyApp.Customer.Profile.create(%{
      ...>   name: "Fetinho",
      ...>   age: -1
      ...> })
      iex> changeset.action
      :insert
      iex> changeset.valid?
      false

      iex> changeset = MyApp.Customer.Profile.create(%{
      ...>   name: "Vandercleisson da Silva"
      ...> })
      iex> changeset.action
      :insert
      iex> changeset.valid?
      false

      iex> changeset = MyApp.Customer.Profile.create(%{age: 18})
      iex> changeset.action
      :insert
      iex> changeset.valid?
      false
  """
  def create(params) do
    %__MODULE__{}
    |> cast(params, [:name, :age])
    |> validate_changeset()
    |> Map.put(:action, :insert)
  end

  @spec update(t | changeset, map) :: changeset(:update)
  @doc """
  Prepares a changeset to _update_ a Profile.

  ## Params

    - `name` - The name of the customer.
    - `age` - The age of the customer.

  ## Examples

      iex> changeset = MyApp.Customer.Profile.update(
      ...>   %MyApp.Customer.Profile{name: "Arnesto do Bar", age: 21},
      ...>   %{age: 25}
      ...> )
      iex> changeset.action
      :update
      iex> changeset.valid?
      true
      iex> changeset.changes
      %{age: 25}

      iex> changeset = MyApp.Customer.Profile.update(
      ...>   %MyApp.Customer.Profile{name: "Fetinho", age: 0},
      ...>   %{age: -1}
      ...> )
      iex> changeset.action
      :update
      iex> changeset.valid?
      false

      iex> changeset = MyApp.Customer.Profile.update(
      ...>   %MyApp.Customer.Profile{name: "Vandercleisson da Silva", age: 18},
      ...>   %{age: nil}
      ...> )
      iex> changeset.action
      :update
      iex> changeset.valid?
      false

      iex> changeset = MyApp.Customer.Profile.update(
      ...>   %MyApp.Customer.Profile{name: "João Noname", age: 18},
      ...>   %{name: nil}
      ...> )
      iex> changeset.action
      :update
      iex> changeset.valid?
      false
  """
  def update(data, params) do
    data
    |> cast(params, [:name, :age])
    |> validate_changeset()
    |> Map.put(:action, :update)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end

  @spec validate_changeset(changeset) :: changeset
  defp validate_changeset(changeset) do
    changeset
    |> validate_required([:name, :age])
    # Age is a non-negative number and there's currently no human being older
    # than 123 years.
    |> validate_number(:age, greater_than_or_equal_to: 0, less_than: 130)
    # TODO: properly validate name somehow
    |> validate_length(:name, min: 3)
  end
end
