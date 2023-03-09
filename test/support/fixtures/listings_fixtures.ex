defmodule Dealership.ListingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dealership.Listings` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{})
      |> Dealership.Listings.create_car()

    car
  end
end
