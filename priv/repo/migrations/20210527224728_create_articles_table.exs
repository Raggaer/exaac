defmodule Exaac.Repo.Migrations.CreateArticlesTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string, size: 150, null: false
      add :content, :text, null: false
      add :slug, :string, null: false

      timestamps()
    end
  end
end
