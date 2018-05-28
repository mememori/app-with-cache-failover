defmodule MyApp.Customer do
  @moduledoc """
  The Customer context.
  """

  import Ecto.Query, warn: false

  alias MyApp.Customer.Profile
  alias MyApp.Repo

  @spec list_customer_profiles() :: [Profile.t()]
  @doc """
  Returns the list of customer_profiles.

  ## Examples

      iex> list_customer_profiles()
      [%Profile{}, ...]

  """
  def list_customer_profiles do
    Repo.all(Profile)
  end

  @spec get_profile!(Profile.id()) :: Profile.t() | no_return
  @doc """
  Gets a single profile.

  Raises `Ecto.NoResultsError` if the Profile does not exist.

  ## Examples

      iex> get_profile!("123-456-789")
      %Profile{}

      iex> get_profile!("000-000-000")
      ** (Ecto.NoResultsError)

  """
  def get_profile!(id), do: Repo.get!(Profile, id)

  @spec create_profile(map) :: {:ok, Profile.t()} | {:error, Profile.changeset()}
  @doc """
  Creates a profile.

  ## Examples

      iex> create_profile(%{field: value})
      {:ok, %Profile{}}

      iex> create_profile(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_profile(attrs) do
    attrs
    |> Profile.create()
    |> Repo.insert()
  end

  @spec create_many_profiles([map]) :: {:ok, [Profile.t()]} | {:error, [Profile.changeset()]}
  @doc """
  Creates several profiles at once.

  This operation is atomic.

  On error, only the invalid changesets are returned.

  ## Examples

      iex> create_many_profiles([
      ...>   %{name: "Roberval Santos", age: 32},
      ...>   %{name: "Levandovski Dmitri de Jesus", age: 41}
      ...> ])
      {:ok, [%Profile{}, %Profile{}]}

      iex> create_many_profiles([
      ...>   %{name: "Weeabito Brasil", age: 21},
      ...>   %{name: "Invalidilson", age: -21}
      ...> ])
      {:error, [%Ecto.Changeset{}]}
  """
  def create_many_profiles(attr_list) do
    changesets = Enum.map(attr_list, &Profile.create/1)

    Repo.transaction(fn ->
      unless Enum.all?(changesets, & &1.valid?) do
        bad_changesets = Enum.filter(changesets, &(not &1.valid?))

        Repo.rollback(bad_changesets)
      end

      for changeset <- changesets do
        case Repo.insert(changeset) do
          {:ok, profile} ->
            profile

          {:error, changeset} ->
            Repo.rollback([changeset])
        end
      end
    end)
  end

  @spec update_profile(Profile.t(), map) :: {:ok, Profile.t()} | {:error, Profile.changeset()}
  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(profile, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_profile(profile, attrs) do
    profile
    |> Profile.update(attrs)
    |> Repo.update()
  end

  @spec delete_profile(Profile.t()) :: {:ok, Profile.t()} | {:error, Profile.changeset()}
  @doc """
  Deletes a Profile.

  ## Examples

      iex> delete_profile(profile)
      {:ok, %Profile{}}

      iex> delete_profile(profile)
      {:error, %Ecto.Changeset{}}

  """
  def delete_profile(profile) do
    Repo.delete(profile)
  end

  @spec delete_all_profiles() :: {:ok, non_neg_integer}
  @doc """
  Deletes all existing profiles.

  Note that this is a destructive operation that will just cause havoc and
  should never be used in the real world...

  This function returns the amount of profiles deleted.

  ## Examples

      iex> delete_all_profiles()
      {:ok, 123}
  """
  def delete_all_profiles do
    {n, _} = Repo.delete_all(Profile)

    {:ok, n}
  end
end
