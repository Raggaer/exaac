defmodule ExaacWeb.ArticleController do
  use ExaacWeb, :controller

  alias Exaac.Articles
  alias Exaac.Articles.Article

  plug :load_article when action in [:edit, :update, :delete]

  defp load_article(conn, _) do
    assign(conn, :current_article, Articles.get_by_id!(conn.params["id"])) 
  end

  def index(conn, _) do
    articles = Articles.get_all
    render(conn, "index.html", articles: articles)
  end

  def new(conn, _) do
    changeset =
      %Article{}
      |> Articles.changeset
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"article" => article}) do
    case Articles.create(article) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Article created successfully!")
        |> redirect(to: Routes.article_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, _) do
    render(conn, "edit.html", changeset: Articles.changeset(conn.assigns.current_article))
  end

  def update(conn, %{"article" => video_params}) do
    case Articles.update(conn.assigns.current_article, video_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Article updated successfully!")
        |> redirect(to: Routes.article_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _} = Articles.delete(conn.assigns.current_article)

    conn
    |> put_flash(:info, "Article deleted successfully!")
    |> redirect(to: Routes.article_path(conn, :index))
  end
end
