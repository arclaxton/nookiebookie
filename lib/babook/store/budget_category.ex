defmodule Babook.Store.BudgetCategory do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "budget_categories" do
		field :name, :string
		timestamps()
	end

	def changeset(budget, attrs) do
		budget
		|> cast(attrs, [:name])
		|> validate_required([:name])
	end

end