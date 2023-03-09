defmodule Dealership.ListingsTest do
  use Dealership.DataCase

  alias Dealership.Listings

  describe "cars" do
    alias Dealership.Listings.Car

    import Dealership.ListingsFixtures

    @invalid_attrs %{}

    test "list_cars/0 returns all cars" do
      car = car_fixture()
      assert Listings.list_cars() == [car]
    end

    test "get_car!/1 returns the car with given id" do
      car = car_fixture()
      assert Listings.get_car!(car.id) == car
    end

    test "create_car/1 with valid data creates a car" do
      valid_attrs = %{}

      assert {:ok, %Car{} = car} = Listings.create_car(valid_attrs)
    end

    test "create_car/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Listings.create_car(@invalid_attrs)
    end

    test "update_car/2 with valid data updates the car" do
      car = car_fixture()
      update_attrs = %{}

      assert {:ok, %Car{} = car} = Listings.update_car(car, update_attrs)
    end

    test "update_car/2 with invalid data returns error changeset" do
      car = car_fixture()
      assert {:error, %Ecto.Changeset{}} = Listings.update_car(car, @invalid_attrs)
      assert car == Listings.get_car!(car.id)
    end

    test "delete_car/1 deletes the car" do
      car = car_fixture()
      assert {:ok, %Car{}} = Listings.delete_car(car)
      assert_raise Ecto.NoResultsError, fn -> Listings.get_car!(car.id) end
    end

    test "change_car/1 returns a car changeset" do
      car = car_fixture()
      assert %Ecto.Changeset{} = Listings.change_car(car)
    end
  end
end
