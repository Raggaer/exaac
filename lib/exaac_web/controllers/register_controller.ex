defmodule ExaacWeb.RegisterController do
  use ExaacWeb, :controller

  alias Exaac.Accounts.ServerAccounts
  alias Exaac.Accounts.Account.ServerAccount

  def new(conn, _) do
    changeset = ServerAccounts.changeset(%ServerAccount{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"server_account" => server_account}) do
    case ServerAccounts.create(server_account) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Account created successfully!")
        |> redirect(to: Routes.register_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
