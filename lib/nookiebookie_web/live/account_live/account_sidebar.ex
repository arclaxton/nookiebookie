defmodule NookieBookieWeb.AccountLive.Sidebar do
	use NookieBookieWeb, :live_view

	alias NookieBookie.Store
	# alias NookieBookie.Store.Account
# 
	@impl true
	def mount(_params, _session, socket) do
		{:ok, assign(socket, :accounts, list_accounts())}
	end

	# defp apply_action(socket, :edit, %{"id" => id}) do
	# 	socket
	# 	|> assign(:page_title, "Edit Account")
	# 	|> assign(:account, Store.get_account!(id))
	# end

	# defp apply_action(socket, :new, _params) do
	# 	socket
	# 	|> assign(:page_title, "New Account")
	# 	|> assign(:account, %Account{})
	# end

	# defp apply_action(socket, :index, _params) do
	# 	socket
	# 	|> assign(:page_title, "Listing Accounts")
	# 	|> assign(:account, nil)
	# end

	@impl true
	def handle_event("delete", %{"id" => id}, socket) do
		account = Store.get_account!(id)
		{:ok, _} = Store.delete_account(account)

		{:noreply, assign(socket, :accounts, list_accounts())}
	end

	defp list_accounts do
		Store.list_accounts()
	end
end
