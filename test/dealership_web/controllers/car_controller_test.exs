defmodule DealershipWeb.CarControllerTest do
  use DealershipWeb.ConnCase

  import Dealership.ListingsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all cars", %{conn: conn} do
      conn = get(conn, ~p"/cars")
      assert html_response(conn, 200) =~ "Listing Cars"
    end
  end

  describe "new car" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/cars/new")
      assert html_response(conn, 200) =~ "New Car"
    end
  end

  describe "create car" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/cars", car: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/cars/#{id}"

      conn = get(conn, ~p"/cars/#{id}")
      assert html_response(conn, 200) =~ "Car #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/cars", car: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Car"
    end
  end

  describe "edit car" do
    setup [:create_car]

    test "renders form for editing chosen car", %{conn: conn, car: car} do
      conn = get(conn, ~p"/cars/#{car}/edit")
      assert html_response(conn, 200) =~ "Edit Car"
    end
  end

  describe "update car" do
    setup [:create_car]

    test "redirects when data is valid", %{conn: conn, car: car} do
      conn = put(conn, ~p"/cars/#{car}", car: @update_attrs)
      assert redirected_to(conn) == ~p"/cars/#{car}"

      conn = get(conn, ~p"/cars/#{car}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, car: car} do
      conn = put(conn, ~p"/cars/#{car}", car: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Car"
    end
  end

  describe "delete car" do
    setup [:create_car]

    test "deletes chosen car", %{conn: conn, car: car} do
      conn = delete(conn, ~p"/cars/#{car}")
      assert redirected_to(conn) == ~p"/cars"

      assert_error_sent 404, fn ->
        get(conn, ~p"/cars/#{car}")
      end
    end
  end

  defp create_car(_) do
    car = car_fixture()
    %{car: car}
  end
end
