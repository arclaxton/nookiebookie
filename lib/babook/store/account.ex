defmodule Babook.Store.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :name, :string
    field :owner, :string
    field :plaid_id, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :owner, :plaid_id])
    |> validate_required([:name, :owner, :plaid_id])
    |> unique_constraint(:plaid_id)
  end
end
