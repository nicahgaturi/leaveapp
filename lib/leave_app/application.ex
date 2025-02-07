defmodule LeaveApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeaveAppWeb.Telemetry,
      LeaveApp.Repo,
      {DNSCluster, query: Application.get_env(:chat_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LeaveApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LeaveApp.Finch},
      # Start a worker by calling: LeaveApp.Worker.start_link(arg)
      # {LeaveApp.Worker, arg},
      # Start to serve requests, typically the last entry
      LeaveAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LeaveApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeaveAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
