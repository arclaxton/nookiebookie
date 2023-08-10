defmodule NookieBookie.Repo.Migrations.CreateBudgetsTable do
	use Ecto.Migration

	def change do
		create table(:budgets, primary_key: false) do
			add :id, :binary_id, primary_key: true
			add :year, :integer
			add :month, :integer
			add :total, :float
			add :category_id, references(:categories, on_delete: :nothing)

			timestamps()
		end
	end
end
