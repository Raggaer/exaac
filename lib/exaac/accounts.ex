defmodule Exaac.Accounts do
  alias Exaac.Repo
  alias Exaac.Accounts.Account.ServerAccount

  def valid_email?(nil) do
    false
  end

  def valid_email?(email) do
    String.contains?(email, "@")
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
