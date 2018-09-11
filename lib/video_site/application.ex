defmodule VideoSite.Application do
  use Application

  def start(_type, _args) do
    start_cowboy()
    children = []
    opts = [strategy: :one_for_one, name: VideoSite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_cowboy() do
    root_path = {"/", :cowboy_static, {:priv_file, :video_site, "static/index.html"}}
    static_route = {"/[...]", :cowboy_static, {:priv_dir, :video_site, "static"}}
    main_route = {:_, VideoSite.Web.PageHandler, VideoSite.Web.Router}

    dispatch = :cowboy_router.compile([{:_, [root_path, static_route, main_route]}])

    opts = [port: 4000]
    env = [dispatch: dispatch]

    case :cowboy.start_http(:http, 10, opts, env: env) do
      {:ok, _pid} -> IO.puts("Cowboy is now running. Go to http://localhost:4000")
      _ -> IO.puts("Error starting Cowboy web server")
    end
  end
end
