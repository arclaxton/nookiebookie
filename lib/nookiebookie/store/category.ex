defmodule NookieBookie.Store.Category do
	use Ecto.Schema
	import Ecto.Changeset

	@primary_key {:id, :binary_id, autogenerate: true}
	schema "budget_categories" do
		field :name, :string

		timestamps()
	end

	@doc false
	def changeset(account, attrs) do
		account
		|> cast(attrs, [:name])
		|> validate_required([:name])
	end
end
