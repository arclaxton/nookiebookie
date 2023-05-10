defmodule Babook.Plaid do

	def get_transactions() do
		response = HTTPoison.post! plaid_url() <> "/transactions/get",
		~s({
			"access_token": "#{get_access_token()}",
			"client_id": "#{get_client_id()}",
			"secret": "#{get_client_secret()}",
			"start_date": "2022-11-01",
			"end_date": "2022-11-06"
		}),
		headers()

		response.body
			|> Poison.decode!
	end

	def get_accounts() do
		response = HTTPoison.post! plaid_url() <> "/accounts/get",
		~s({
			"access_token": "#{get_access_token()}",
			"client_id": "#{get_client_id()}",
			"secret": "#{get_client_secret()}"
		}),
		headers()

		response.body
			|> Poison.decode!
	end

	def get_item() do
		response = HTTPoison.post! plaid_url() <> "/item/get",
		~s({
			"access_token": "#{get_access_token()}",
			"client_id": "#{get_client_id()}",
			"secret": "#{get_client_secret()}"
		}),
		headers()

		response.body
			|> Poison.decode! 
			|> Map.fetch("item")
	end

	def headers do
		[
			{"Content-Type", "Application/json"}
		]
	end
	def plaid_url do
		"https://development.plaid.com"
	end
	def get_client_id do
		"*****"
	end
	def get_client_secret do
		"*****"
	end
	def get_access_token do
		"*****"
	end

end