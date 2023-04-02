defmodule :"Elixir.Babook.Repo.Migrations.Plaid-transaction-fields" do
	use Ecto.Migration

	def change do
		alter table(:transactions) do
			add :category_id, :string
			add :plaid_id, :string
			add :pending, :boolean, default: false
			add :date, :date
			add :name, :string
			add :currency, :string
		end
	end
end
