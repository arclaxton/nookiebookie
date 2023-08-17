defmodule Nookiebookie.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :plaid_token, :string

      timestamps()
    end
  end
end
