defmodule Babook.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account, :integer
      add :amount, :float
      add :transfer, :boolean, default: false, null: false
      add :merchant, :string
      add :category, :string
      add :budget_allocation, :integer

      timestamps()
    end
  end
end
