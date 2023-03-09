defmodule Mix.Tasks.Dealership.Importer do
  use Mix.Task
  alias Dealership.Repo
  alias Dealership.InventorySync.{Downloader, Importer}


  @shortdoc "Syncs inventory"
  @url 'https://elixircastsio.github.io/inventory/incoming/new_cars.csv'
  @filename "new_inventory.csv"

  def run(_args) do
    # starts the whole app so the Repo service is available to use
    Application.put_env(:dealership, :process_type, :mix_task)
    Mix.Task.run("app.start")

    @url
    |> Downloader.download!(@filename)
    |> Importer.sync_inventory!
  end
end
