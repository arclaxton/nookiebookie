defmodule Babook.Store.Budget do
	use Ecto.Schema
	import Ecto.Changeset
	import Ecto.Association
	import Ecto.Query

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "transactions" do
		field :year, :integer
		field :month, :integer
		field :total, :float
		belongs_to :budget_category, Babook.Store.BudgetCategory

		timestamps()
	end

	def changeset(budget, attrs) do
		budget
		|> cast(attrs, [:year, :month, :total])
		|> validate_required([:year, :month, :total])
	end

end