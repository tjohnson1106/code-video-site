defmodule VideoSite.Application do
  use Application

  def start(_type, _args) do
    start_cowboy()
    children = []
    opts = [strategy: :one_for_one, name: VideoSite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_cowboy() do
    route1 = {:_, VideoSite.Web.PageHandler, []}

    dispatch = :cowboy_router.compile([{:_, [route1]}])

    opts = [port: 4000]
    env = [dispatch: dispatch]

    case :cowboy.start_http(:http, 10, opts, env: env) do
      {:ok, _pid} -> IO.puts("Cowboy is now running. Go to http://localhost:4000")
      _ -> IO.puts("Error starting Cowboy web server")
    end
  end
end
