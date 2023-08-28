defmodule NookieBookieWeb.AccountLive.Sidebar do
	use NookieBookieWeb, :live_view

	alias NookieBookie.Store
	# alias NookieBookie.Store.Account

	@impl true
	def mount(_params, _session, socket) do
		{:ok, assign(socket, :accounts, list_accounts())}
	end

	@impl true
	def handle_event("delete", %{"id" => id}, socket) do
		account = Store.get_account!(id)
		{:ok, _} = Store.delete_account(account)

		{:noreply, assign(socket, :accounts, list_accounts())}
	end

	def handle_event("edit", %{"id" => id}, socket) do
		{:noreply, assign(socket, edit_account: id)}
	end

	def handle_event("new", socket) do
		{:noreply, assign(socket, add_account: true)}
	end

	defp list_accounts do
		Store.list_accounts()
	end
end
