defmodule NookieBookie.Store.Account do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	@foreign_key_type :binary_id
	schema "accounts" do
		field :name, :string
		field :owner, :string
		field :balance, :float
		field :plaid_id, :string
		field :plaid_item_id, :string
		field :type, :string
		field :currency, :string

		timestamps()
	end

	@doc false
	def changeset(account, attrs) do
		account
		|> cast(attrs, [:name, :owner, :plaid_id])
		|> validate_required([:name, :owner])
		|> unique_constraint(:plaid_id)
	end
end
