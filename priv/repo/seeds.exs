# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Babook.Repo.insert!(%Babook.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Babook.Store.Transaction
alias Babook.Store.Account
import Ecto.Query

Babook.Repo.delete_all(from t in "transactions")
Babook.Repo.delete_all(from a in "accounts")

Babook.Repo.insert %Account{
	name: "discover",
	owner: "Adam",
	balance: 0.0,
	plaid_id: nil
}

Babook.Repo.insert %Account{
	name: "usaa",
	owner: "Adam",
	balance: 0.0,
	plaid_id: nil
}
