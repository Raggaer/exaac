defmodule Exaac.TestHelpers do
  alias Exaac.Articles

  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
          title: "Article test title",
          content: "Article test content"
        })
      |> Articles.create
    article
  end
end
