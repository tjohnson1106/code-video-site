defmodule VideoSite.Web.Router do
  def call(path) do
    content_for(path)
  end

  defp content_for("/") do
    "<h1>Welcome to code video</h1>"
  end

  defp content_for("/too") do
    "<h1>Welcome to code video too</h1>"
  end

  defp content_for("/contact") do
    ~s{<h1> You can find us on Twitter at <a> href="http://twitter.com/bracketfactory"</a> </h1>}
  end

  defp content_for("/secret") do
    "<h1>Secret Page</h1>"
  end

  defp content_for("/others") do
    body = "<h1>This page does not exist</h1>"
  end
end
