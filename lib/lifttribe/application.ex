defmodule Lifttribe.Application do
  @moduledoc false

  use Application

  alias LifttribeWeb.Endpoint

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Lifttribe.Repo,
      # Start the Telemetry supervisor
      LifttribeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lifttribe.PubSub},
      # Start the Endpoint (http/https)
      Endpoint,
      # Start a worker by calling: Lifttribe.Worker.start_link(arg)
      # {Lifttribe.Worker, arg}
      {Finch, name: Swoosh.Finch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lifttribe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
