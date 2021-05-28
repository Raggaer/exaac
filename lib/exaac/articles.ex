defmodule Exaac.Articles do
  alias Exaac.Repo
  alias Exaac.Articles.Article

  import Ecto.Query

  def get_by_id(id) do
    Repo.get(Article, id)
  end

  def get_by_id!(id) do
    Repo.get!(Article, id)
  end

  def get_all do
    Article
    |> get_all_query
    |> Repo.all
  end

  defp get_all_query(query) do
    from a in query,
      order_by: [desc: a.id]
  end

  def list_latest(limit) when is_integer(limit) do
    Article 
    |> list_latest_query(limit)
    |> Repo.all
  end

  defp list_latest_query(query, limit) do
    from a in query,
      limit: ^limit,
      order_by: [desc: a.id]
  end

  def create_with_title_and_content!(title, content) do
    %Article{}
    |> Article.changeset(%{title: title, content: content})
    |> Repo.insert!
  end

  def create(params) do
    %Article{}
    |> Article.changeset(params)
    |> Repo.insert
  end

  def update(%Article{} = article, params \\ %{}) do
    article
    |> Article.changeset(params) 
    |> Repo.update
  end

  def delete(%Article{} = article) do
    Repo.delete(article)
  end

  def changeset(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
