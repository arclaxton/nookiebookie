defmodule Babook.Store.Transaction do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "transactions" do
		field :account, :integer
		field :amount, :float
		field :budget_allocation, :integer
		field :category, :string
		field :merchant, :string
		field :transfer, :boolean, default: false

		timestamps()
	end

	@doc false
	def changeset(transaction, attrs) do
		transaction
		|> cast(attrs, [:account, :amount, :transfer, :merchant, :category, :budget_allocation])
		|> validate_required([:account, :amount, :transfer, :merchant, :category, :budget_allocation])
	end
end
