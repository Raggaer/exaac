defmodule Exaac.ArticlesTest do
  use Exaac.DataCase, async: true

  alias Exaac.Articles
  alias Exaac.Articles.Article
  alias Exaac.TestHelpers

  @valid_attrs %{
    title: "Article test title",
    content: "Article test content"
  }

  @invalid_attrs %{
    title: "",
    content: ""
  }

  describe "create/1" do
    test "valid data creates article" do
      assert {:ok, %Article{id: id}} = Articles.create(@valid_attrs)
      assert [%Article{id: ^id}] = Articles.get_all
    end

    test "invalid data fails create article" do
      assert {:error, changeset} = Articles.create(@invalid_attrs)
      assert %{title: ["can't be blank"], content: ["can't be blank"]} = errors_on(changeset)
    end
  end

  describe "update/2" do
    test "update article with valid data" do
      %Article{id: id} = article = TestHelpers.article_fixture
      assert [%Article{id: ^id}] = Articles.get_all

      new_title = "This article has been updated"
      assert {:ok, %Article{title: ^new_title}} = Articles.update(article, %{title: new_title})
    end

    test "update article with invalid data" do
      %Article{id: id} = article = TestHelpers.article_fixture
      assert [%Article{id: ^id}] = Articles.get_all

      new_title = String.duplicate("a", 200)
      assert {:error, changeset} = Articles.update(article, %{title: new_title})
      assert %{title: ["should be at most 150 character(s)"]} = errors_on(changeset)
    end
  end

  describe "delete/1" do
    test "delete valid article" do
      %Article{id: id} = article = TestHelpers.article_fixture
      assert [%Article{id: ^id}] = Articles.get_all

      assert {:ok, _} = Articles.delete(article)
    end
  end
end
