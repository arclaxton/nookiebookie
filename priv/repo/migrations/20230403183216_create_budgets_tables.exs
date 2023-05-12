defmodule NookieBookie.Repo.Migrations.CreateBudgetsTable do
	use Ecto.Migration

	def change do
		create table(:budget_categories, primary_key: false) do
			add :name, :string
			timestamps()
		end
		create table(:budgets, primary_key: false) do
			add :year, :integer
			add :month, :integer
			add :total, :float
			add :budget_category_id, references(:budget_categories, on_delete: :nothing)

			timestamps()
		end
	end
end
