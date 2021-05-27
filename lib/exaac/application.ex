defmodule Exaac.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Exaac.Repo,
      # Start the Telemetry supervisor
      ExaacWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Exaac.PubSub},
      # Start the Endpoint (http/https)
      ExaacWeb.Endpoint
      # Start a worker by calling: Exaac.Worker.start_link(arg)
      # {Exaac.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exaac.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExaacWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
