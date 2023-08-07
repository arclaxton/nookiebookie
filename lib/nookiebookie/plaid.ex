defmodule NookieBookie.Plaid do

	def get_transactions() do
		# case Plaid.Accounts.get(%{access_token: token}) do
		# 	{:ok, %Plaid.Accounts{accounts: accts}} ->
		# 	conn
		# 	|> put_status(200)
		# 	|> json(accts)
		# 	{:error, %Plaid.Error{error_message: msg}} ->
		# 	conn
		# 	|> put_status(400)
		# 	|> json(%{message: msg})
		# 	{:error, reason} ->
		# 	conn
		# 	|> put_status(400)
		# 	|> json(%{message: "Request failed, please try again."})
		# end
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