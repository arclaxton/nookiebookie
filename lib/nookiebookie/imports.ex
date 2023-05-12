defmodule NookieBookie.Imports do
	use Timex
	def transactions_from_plaid() do
		transactions = NookieBookie.Plaid.get_transactions()["transactions"]
		for trx <- transactions do
			NookieBookie.Repo.insert!(%NookieBookie.Store.Transaction{
				account: 0,
				amount: trx["amount"] * 1.0,
				budget_allocation: nil,
				category_id: trx["category_id"],
				transfer: false,
				plaid_id: trx["transaction_id"],
				pending: trx["pending"],
				date: Date.from_iso8601!(trx["date"]),
				name: trx["name"],
				currency: "USD",
			})
		end
	end
end