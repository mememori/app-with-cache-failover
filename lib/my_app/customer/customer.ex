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
end
