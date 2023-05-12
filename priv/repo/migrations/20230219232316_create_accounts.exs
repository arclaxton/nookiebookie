defmodule NookieBookie.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :owner, :string
      add :plaid_id, :string

      timestamps()
    end

    create unique_index(:accounts, [:plaid_id])
  end
end
