defmodule MyApp.CustomerTest do
  use MyApp.DataCase

  alias MyApp.Customer
  alias MyApp.Repo

  describe "customer_profiles" do
    alias MyApp.Customer.Profile

    @valid_attrs %{age: 18, name: "some name"}
    @update_attrs %{age: 21, name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customer.create_profile()

      profile
    end

    test "list_customer_profiles/0 returns all customer_profiles" do
      profile = profile_fixture()
      assert Customer.list_customer_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Customer.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = Customer.create_profile(@valid_attrs)
      assert profile.age == 18
      assert profile.name == "some name"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customer.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()
      assert {:ok, profile} = Customer.update_profile(profile, @update_attrs)
      assert %Profile{} = profile
      assert profile.age == 21
      assert profile.name == "some updated name"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Customer.update_profile(profile, @invalid_attrs)
      assert profile == Customer.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Customer.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Customer.get_profile!(profile.id) end
    end

    test "delete_all_profiles/0 deletes all profiles from db" do
      profile_fixture()
      profile_fixture()
      profile_fixture()

      assert Repo.aggregate(Profile, :count, :id) == 3
      assert Customer.delete_all_profiles() == {:ok, 3}
      assert Repo.aggregate(Profile, :count, :id) == 0
      assert Customer.delete_all_profiles() == {:ok, 0}
    end
  end
end
