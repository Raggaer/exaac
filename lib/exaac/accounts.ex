defmodule Exaac.Accounts do
  alias Exaac.Repo

  alias Exaac.Accounts.WebsiteAccounts
  alias Exaac.Accounts.ServerAccounts

  alias Exaac.Accounts.Account.WebsiteAccount
  alias Exaac.Accounts.Account.ServerAccount

  def valid_email?(nil) do
    false
  end

  def valid_email?(email) do
    String.contains?(email, "@")
  end

  def create(params) do
    Repo.transaction(fn ->
      # Create server account
      account = case ServerAccounts.create(params) do
        {:ok, account} -> account
        {:error, changeset} -> Repo.rollback(changeset)
      end
      
      # Create website account
      case WebsiteAccounts.create(%{account_id: account.id}) do
        {:ok, _} -> :ok
        {:error, changeset} -> Repo.rollback(changeset)
      end

      account
    end)
  end

  defmodule WebsiteAccounts do
    def create(params) do
      %WebsiteAccount{}
      |> WebsiteAccount.changeset(params)
      |> Repo.insert
    end

    def changeset(account, params \\ %{}) do
      account
        |> WebsiteAccount.changeset(params)
    end

    def get_all do
      WebsiteAccount
      |> Repo.all
    end
  end

  defmodule ServerAccounts do
    def get_all do
      ServerAccount
      |> Repo.all
    end

    def changeset(account, params \\ %{}) do
      account
      |> ServerAccount.changeset(params)
    end

    def create(params) do
      %ServerAccount{}
      |> ServerAccount.register_changeset(params)
      |> Repo.insert
    end

    def update(account, params) do
      account
      |> ServerAccount.update_changeset(params)
      |> Repo.update
    end
  end
end
