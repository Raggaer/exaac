defmodule Exaac.TestHelpers do
  alias Exaac.Articles
  alias Exaac.Accounts.ServerAccounts

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

  def server_account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
          name: "Testing",
          email: "test@test.com",
          password_plain: "testing1234",
          password_plain_confirmation: "testing1234"
        })
      |> ServerAccounts.create
      account
  end
end
