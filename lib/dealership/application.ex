defmodule Dealership.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DealershipWeb.Telemetry,
      # Start the Ecto repository
      Dealership.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dealership.PubSub},
      # Start Finch
      {Finch, name: Dealership.Finch},
      # Start the Endpoint (http/https)
      DealershipWeb.Endpoint
      # Start a worker by calling: Dealership.Worker.start_link(arg)
      # {Dealership.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dealership.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DealershipWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
