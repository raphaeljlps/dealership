defmodule DealershipWeb.CarHTML do
  use DealershipWeb, :html
  import Number.Currency

  embed_templates "car_html/*"

  @doc """
  Renders a car form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def car_form(assigns)

  def car_title(car) do
    "#{car.car_Year} #{car.car_Make} #{car.car_Model} #{car.car_pk}"
  end

  def format_price(price) do
    Number.Currency.number_to_currency(price)
  end

  def format_mileage(miles) do
    Number.Delimit.number_to_delimited(miles, precision: 0)
  end
end
