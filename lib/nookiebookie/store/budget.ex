defmodule NookieBookie.Store.Budget do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "budgets" do
		field :year, :integer
		field :month, :integer
		field :total, :float

		belongs_to :category, NookieBookie.Store.Category

		timestamps()
	end

	def changeset(budget, attrs) do
		budget
		|> cast(attrs, [:year, :month, :total])
		|> validate_required([:year, :month, :total])
	end

end
