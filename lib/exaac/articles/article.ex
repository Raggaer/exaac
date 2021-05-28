defmodule Exaac.Articles.Article do
  use Ecto.Schema

  import Ecto.Changeset

  schema "articles" do
    field :title, :string
    field :content, :string
    field :slug, :string

    timestamps()
  end

  def changeset(article, params) do
    article
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
    |> validate_length(:title, max: 150)
    |> slugify_title
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, title} -> put_change(changeset, :slug, slugify(title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]/u, "-")
  end
end
