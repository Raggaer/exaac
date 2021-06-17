defmodule Exaac.Repo.Migrations.AddWebsiteAccounts do
  use Ecto.Migration

  def change do
    create table("website_accounts") do
      add :account_id, references("accounts", [type: :integer, on_delete: :delete_all])
      timestamps()
    end
  end
end
