defmodule Exaac.Accounts.Account do 
  defmodule WebsiteAccount do
    use Ecto.Schema

    import Ecto.Changeset

    alias Exaac.Accounts

    schema "website_accounts" do
      #field :account_id, :integer

      belongs_to :accounts, Exaac.Accounts.Account.ServerAccount, [foreign_key: :account_id]

      timestamps()
    end

    def changeset(account, params) do
      account
      |> cast(params, [:account_id])
    end
  end

  defmodule ServerAccount do
    use Ecto.Schema

    import Ecto.Changeset

    alias Exaac.Accounts

    schema "accounts" do
      field :name, :string 
      field :password_plain, :string, virtual: true
      field :password_plain_confirmation, :string, virtual: true
      field :password, :string 
      field :email, :string
      field :creation, :integer

      has_one :website_accounts, Exaac.Accounts.Account.WebsiteAccount
    end

    def changeset(account, params) do
      account
      |> cast(params, [:name, :email, :password_plain, :password_plain_confirmation])
      |> validate_required([:name, :email, :password_plain])
      |> validate_length(:name, max: 32)
      |> validate_length(:email, max: 70)
      |> validate_length(:password_plain, max: 70)
      |> unique_constraint(:name, name: :name)
      |> unique_constraint(:email, name: :email)
      |> validate_email
      |> validate_name
    end

    def update_changeset(account, params) do
      changeset(account, params)
      |> put_hash_password
    end

    def register_changeset(account, params) do
      changeset(account, params)
      |> validate_required([:password_plain_confirmation])
      |> validate_confirmation(:password_plain, message: "passwords do not match")
      |> put_creation
      |> put_hash_password
    end

    defp put_creation(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true} ->
          put_change(changeset, :creation, :os.system_time(:seconds))
        _ ->
          changeset
      end
    end

    defp put_hash_password(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password_plain: pass}} ->
          put_change(changeset, :password, hash_password(pass))
        _ -> 
          changeset
      end
    end

    defp hash_password(password) do
      :crypto.hash(:sha, password)
      |> Base.encode16([case: :lower])
    end

    defp validate_name(changeset) do
      name = get_field(changeset, :name, "") || ""
      case String.match?(name, ~r/^[A-Za-z0-9_-]+$/) do
        false -> add_error(changeset, :name, "invalid account name format")
        _ -> changeset
      end
    end

    defp validate_email(changeset) do
      email = get_field(changeset, :email, "")
      case Accounts.valid_email?(email) do
        false -> add_error(changeset, :email, "invalid email address")
        _ -> changeset
      end
    end
  end
end
