defmodule Babook.Repo.Migrations.AccountPlaidFields do
	use Ecto.Migration

	def change do
		alter table(:accounts) do
			add :plaid_item_id, :string
			add :type, :string
			add :currency, :string
		end
	end
end
