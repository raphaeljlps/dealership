defmodule DealershipWeb.CarController do
  use DealershipWeb, :controller

  alias Dealership.Listings


  def index(conn, _params) do
    cars = Listings.list_cars()
    render(conn, :index, cars: cars)
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
      |> Listings.get_car!()

    render(conn, :show, car: car)
  end
end
