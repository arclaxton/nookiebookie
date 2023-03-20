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

Babook.Repo.insert! %Transaction{
	account: 0,
	amount: 20.0,
	budget_allocation: 0,
	category: "category",
	merchant: "merchant",
	transfer: false
}
Babook.Repo.insert! %Transaction{
	account: 0,
	amount: 20.0,
	budget_allocation: 0,
	category: "category",
	merchant: "merchant",
	transfer: false
}
Babook.Repo.insert! %Transaction{
	account: 0,
	amount: 20.0,
	budget_allocation: 0,
	category: "category",
	merchant: "merchant",
	transfer: false
}
Babook.Repo.insert! %Transaction{
	account: 0,
	amount: 20.0,
	budget_allocation: 0,
	category: "category",
	merchant: "merchant",
	transfer: false
}
Babook.Repo.insert! %Transaction{
	account: 0,
	amount: 20.0,
	budget_allocation: 0,
	category: "category",
	merchant: "merchant",
	transfer: false
}