defmodule Poolb.Supervisor do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def init(_opts) do
    pool_options = [
      name: {:local, :worker_pool},
      worker_module: Poolb.Worker,
      size: 3,
      max_overflow: 0
    ]

    children = [
      :poolboy.child_spec(:worker_pool, pool_options, [])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
 
end
