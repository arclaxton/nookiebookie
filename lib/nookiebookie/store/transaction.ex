defmodule NookieBookie.Store.Transaction do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "transactions" do
		field :account, :integer
		field :amount, :float
		field :budget_allocation, :integer
		field :category, :string
		field :category_id, :string
		field :merchant, :string
		field :transfer, :boolean, default: false
		field :plaid_id, :string
		field :pending, :boolean, default: false
		field :date, :date
		field :name, :string
		field :currency, :string

		timestamps()
	end

	@doc false
	def changeset(transaction, attrs) do
		transaction
		|> cast(attrs, 
			[
				:account, 
				:amount, 
				:transfer, 
				:merchant, 
				:category,
				:budget_allocation,
				:category_id,
				:plaid_id,
				:pending,
				:date,
				:name,
				:currency
			]
		)
		|> validate_required([:account, :amount, :transfer])
	end
end
