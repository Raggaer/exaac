defmodule ExaacWeb.PageControllerTest do
  use ExaacWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Latest News"
  end
end
