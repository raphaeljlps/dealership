defmodule DealershipWeb.CarController do
  use DealershipWeb, :controller

  alias Dealership.Listings
  alias Dealership.Listings.Car

  def index(conn, _params) do
    cars = Listings.list_cars()
    render(conn, :index, cars: cars)
  end

  def new(conn, _params) do
    changeset = Listings.change_car(%Car{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"car" => car_params}) do
    case Listings.create_car(car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car created successfully.")
        |> redirect(to: ~p"/cars/#{car}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  defp id_from_slug(slug) do
    slug
    |> String.split("-")
    |> List.last()
  end

  def show(conn, %{"id" => slug}) do
    car =
      slug
      |> id_from_slug
      |> Listings.get_car!
    render(conn, :show, car: car)
  end

  def edit(conn, %{"id" => id}) do
    car = Listings.get_car!(id)
    changeset = Listings.change_car(car)
    render(conn, :edit, car: car, changeset: changeset)
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    car = Listings.get_car!(id)

    case Listings.update_car(car, car_params) do
      {:ok, car} ->
        conn
        |> put_flash(:info, "Car updated successfully.")
        |> redirect(to: ~p"/cars/#{car}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, car: car, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    car = Listings.get_car!(id)
    {:ok, _car} = Listings.delete_car(car)

    conn
    |> put_flash(:info, "Car deleted successfully.")
    |> redirect(to: ~p"/cars")
  end
end
