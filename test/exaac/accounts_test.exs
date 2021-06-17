defmodule Exaac.AccountsTest do
  use Exaac.DataCase, async: true

  alias Exaac.Accounts

  alias Exaac.Accounts.ServerAccounts
  alias Exaac.Accounts.WebsiteAccounts
  alias Exaac.Accounts.Account.ServerAccount
  alias Exaac.Accounts.Account.WebsiteAccount
  
  alias Exaac.TestHelpers

  @valid_attrs %{
    name: "Raggaer",
    password_plain: "testing1234",
    password_plain_confirmation: "testing1234",
    email: "admin@exaac.com"
  }

  @invalid_attrs %{
    name: "Raggaer",
    email: "admin@exaac.com"
  } 

  @invalid_password_match %{
    password_plain: "test1234",
    password_plain_confirmation: "test4321"
  }

  @invalid_email %{
    name: "Raggaer",
    email: "invalid.com",
    password_plain: "test1234",
    password_plain_confirmation: "test1234",
  }

  @invalid_name %{
    name: "Invalid Name",
  }

  @update_attrs %{
    name: "New_Name"
  }

  describe "create whole account" do
    test "create account with valid data" do
      {:ok, %ServerAccount{id: id}} = Accounts.create(@valid_attrs)

      assert [%ServerAccount{id: ^id}] = ServerAccounts.get_all
      assert [%WebsiteAccount{account_id: ^id}] = WebsiteAccounts.get_all
    end
  end

  describe "create/1" do
    test "create account with valid data" do
      {:ok, %ServerAccount{id: id, creation: creation, password: pw}} = ServerAccounts.create(@valid_attrs)
      assert [%ServerAccount{id: ^id, creation: ^creation, password: ^pw}] = ServerAccounts.get_all
    end

    test "create account with invalid data" do
      {:error, changeset} = ServerAccounts.create(@invalid_attrs)
      assert %{password_plain: ["can't be blank"]} = errors_on(changeset)
      assert [] = ServerAccounts.get_all
    end

    test "create account name already exists" do
      TestHelpers.server_account_fixture(@valid_attrs)

      {:error, changeset} = ServerAccounts.create(@valid_attrs)
      assert %{name: ["has already been taken"]} = errors_on(changeset)

      assert [_] = ServerAccounts.get_all
    end

    test "create account passwords do not match" do
      {:error, changeset} = ServerAccounts.create(@invalid_password_match)
      assert %{password_plain_confirmation: ["passwords do not match"]} = errors_on(changeset)
      assert [] = ServerAccounts.get_all
    end

    test "create account invalid email" do
      {:error, changeset} = ServerAccounts.create(@invalid_email)
      assert %{email: ["invalid email address"]} = errors_on(changeset)
      assert [] = ServerAccounts.get_all
    end

    test "create account invalid name" do
      {:error, changeset} = ServerAccounts.create(@invalid_name)
      assert %{name: ["invalid account name format"]} = errors_on(changeset)
      assert [] = ServerAccounts.get_all
    end
  end

  describe "update/2" do
    test "update account with valid data" do
      account = TestHelpers.server_account_fixture(@valid_attrs)
      {:ok, %ServerAccount{name: name}} = ServerAccounts.update(account, @update_attrs)

      assert account.name != name
    end

    test "update account with invalid data" do
      %ServerAccount{name: name} = account = TestHelpers.server_account_fixture(@valid_attrs)
      {:error, changeset} = ServerAccounts.update(account, %{name: ""})

      assert %{name: ["can't be blank"]} = errors_on(changeset)
      assert [%ServerAccount{name: ^name}] = ServerAccounts.get_all
    end
  end
end

