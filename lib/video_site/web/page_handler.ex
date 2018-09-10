defmodule VideoSite.Web.PageHandler do
  def init({:tcp, :http}, req, state) do
    {:ok, req, state}
  end

  def handle(req, state) do
    headers = [{"content-type", "text/html"}]

    {path, req} = :cowboy_req.path(req)
    {:ok, resp} = :cowboy_req.reply(200, headers, content_for(path), req)
    {:ok, resp, :empty}
  end

  # passing routes

  def content_for("/") do
    "<h1>Welcome to code video</h1>"
  end

  def content_for("/too") do
    "<h1>Welcome to code video too</h1>"
  end

  def content_for("/contact") do
    ~s{<h1> You can find us on Twitter at <a> href="http://twitter.com/bracketfactory"</a> </h1>}
  end

  def content_for("/secret") do
    "<h1>Secret Page</h1>"
  end

  def content_for("/others") do
    body = "<h1>This page does not exist</h1>"
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
