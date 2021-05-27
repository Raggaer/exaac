defmodule ExaacWeb.PageController do
  use ExaacWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
