defmodule Poolb.Worker do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    {:ok, opts}
  end

  def work() do
    Task.async(
      fn ->
        :poolboy.transaction(:worker_pool,
                             &GenServer.call(&1, :work))
      end)
  end

  def handle_call(:work, _from, state) do
    IO.puts("Start")
    Process.sleep(4000)
    IO.puts("Stop")
    {:reply, "test", state}
  end

end
