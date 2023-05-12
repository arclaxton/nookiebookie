defmodule NookieBookie.Repo.Migrations.CreateBudgetsTable do
	use Ecto.Migration

	def change do
		create table(:budget_categories, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :name, :string
			timestamps()
		end
		create table(:budgets, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :year, :integer
			add :month, :integer
			add :total, :float
			add :budget_category_id, references(:budget_categories, on_delete: :nothing)

			timestamps()
		end
	end
end
