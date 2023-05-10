defmodule Babook.Repo.Migrations.BudgetPrimaryKeys do
	use Ecto.Migration

	def change do
		alter table(:budgets) do
			add :id, :binary_id
		end
		alter table(:budget_categories) do
			add :id, :binary_id
		end

	end
end
