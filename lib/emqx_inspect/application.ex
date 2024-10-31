defmodule EmqxInspect.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EmqxInspectWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:emqx_inspect, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EmqxInspect.PubSub},
      # Start a worker by calling: EmqxInspect.Worker.start_link(arg)
      # {EmqxInspect.Worker, arg},
      # Start to serve requests, typically the last entry
      EmqxInspectWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EmqxInspect.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EmqxInspectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
