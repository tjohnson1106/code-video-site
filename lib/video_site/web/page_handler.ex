defmodule VideoSite.Web.PageHandler do
  def init({:tcp, :http}, req, _opts) do
    {:ok, req, :empty}
  end

  def handle(req, _state) do
    headers = [{"content-type", "text/html"}]
    body = "<h1>Welcome to code video</h1>"

    {:ok, resp} = :cowboy_req.reply(200, headers, body, req)
    {:ok, resp, :empty}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
