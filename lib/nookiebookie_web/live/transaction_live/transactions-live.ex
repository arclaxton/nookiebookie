defmodule NookieBookieWeb.TransactionLive.Transactions do
	use NookieBookieWeb, :live_view

	alias NookieBookie.Store
	alias NookieBookie.Store.Transaction

	@topic "transaction"

	@impl true
	def mount(_params, _session, socket) do
		NookieBookieWeb.Endpoint.subscribe(@topic)
		{:ok, socket}
	end

	@impl true
	def handle_params(params, _url, socket) do
		{:noreply, apply_action(socket, socket.assigns.live_action, params)}
	end

	defp apply_action(socket, :edit, %{"id" => id}) do
		socket
		|> assign(:page_title, "Edit Transaction")
		|> assign(:transaction, Store.get_transaction!(id))
	end

	defp apply_action(socket, :new, _params) do
		socket
		|> assign(:page_title, "New Transaction")
		|> assign(:transaction, %Transaction{})
	end

	defp apply_action(socket, :index, params) do
		sort_by = (params["sort_by"] || "date") |> String.to_atom()
		sort_order = (params["sort_order"] || "desc") |> String.to_atom()

		options = %{
			sort_by: sort_by,
			sort_order: sort_order
		}

		socket
		|> assign(:page_title, "Listing Transactions")
		# |> assign(:transaction, nil)
		|> assign(:options, options)
		|> assign(:transactions, Store.list_transactions(options))
	end

	@impl true
	def handle_event("delete", %{"id" => id}, socket) do
		transaction = Store.get_transaction!(id)
		{:ok, _} = Store.delete_transaction(transaction)
		NookieBookieWeb.Endpoint.broadcast("transaction", "deleted", id)

		{:noreply, assign(socket, :transactions, Store.list_transactions())}
	end

	# transaction deleted externally
	# TODO just pop id locally
	@impl true
	def handle_info(%{event: "deleted", payload: _id}, socket) do
		# transaction = Store.get_transaction!(id)
		# {:ok, _} = Store.delete_transaction(transaction)

		{:noreply, assign(socket, :transactions, Store.list_transactions())}
	end

	# transaction updated externally
	# TODO update local transaction
	@impl true
	def handle_info(%{event: "updated", payload: _transaction}, socket) do

		{:noreply, assign(socket, :transactions, Store.list_transactions())}
	end

	def next_sort_order(order) do
		case order do
			:asc -> :desc
			:desc -> :asc
		end
	end
end
