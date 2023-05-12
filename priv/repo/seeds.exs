# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NookieBookie.Repo.insert!(%NookieBookie.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NookieBookie.Store.Transaction
alias NookieBookie.Store.Account
import Ecto.Query

NookieBookie.Repo.delete_all(from t in "transactions")
NookieBookie.Repo.delete_all(from a in "accounts")

NookieBookie.Repo.insert %Account{
	name: "discover",
	owner: "Adam",
	balance: 0.0,
	plaid_id: nil
}

NookieBookie.Repo.insert %Account{
	name: "usaa",
	owner: "Adam",
	balance: 0.0,
	plaid_id: nil
}
