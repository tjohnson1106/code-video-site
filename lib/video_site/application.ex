defmodule VideoSite.Application do
  use Application

  def start(_type, _args) do
    start_cowboy()
    children = []
    opts = [strategy: :one_for_one, name: VideoSite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_cowboy() do
    route1 = {"/", VideoSite.Web.PageHandler, :base}
    route2 = {"/2", VideoSite.Web.PageHandler, :too}
    route3 = {"/contact", VideoSite.Web.PageHandler, :contact}
    route4 = {"/secret", VideoSite.Web.PageHandler, :secret}
    others = {:_, VideoSite.Web.PageHandler, :others}

    dispatch = :cowboy_router.compile([{:_, [route1, route2, route3, route4, others]}])

    opts = [port: 4000]
    env = [dispatch: dispatch]

    case :cowboy.start_http(:http, 10, opts, env: env) do
      {:ok, _pid} -> IO.puts("Cowboy is now running. Go to http://localhost:4000")
      _ -> IO.puts("Error starting Cowboy web server")
    end
  end
end
