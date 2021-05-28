defmodule ExaacWeb.PageController do
  use ExaacWeb, :controller

  alias Exaac.Articles

  def index(conn, _params) do
    articles = Articles.list_latest(5)
    render(conn, "index.html", articles: articles)
  end
end
