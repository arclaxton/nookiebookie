defmodule BabookWeb.TransactionLive.FormComponent do
	use BabookWeb, :live_component

	alias Babook.Store

	@impl true
	def update(%{transaction: transaction} = assigns, socket) do
		changeset = Store.change_transaction(transaction)

		{:ok,
		 socket
		 |> assign(assigns)
		 |> assign(:changeset, changeset)}
	end

	@impl true
	def handle_event("validate", %{"transaction" => transaction_params}, socket) do
		changeset =
			socket.assigns.transaction
			|> Store.change_transaction(transaction_params)
			|> Map.put(:action, :validate)

		{:noreply, assign(socket, :changeset, changeset)}
	end

	def handle_event("save", %{"transaction" => transaction_params}, socket) do
		save_transaction(socket, socket.assigns.action, transaction_params)
	end

	defp save_transaction(socket, :edit, transaction_params) do
		case Store.update_transaction(socket.assigns.transaction, transaction_params) do
			{:ok, _transaction} ->
				{:noreply,
				 socket
				 |> put_flash(:info, "Transaction updated successfully")
				 |> push_redirect(to: socket.assigns.return_to)}

			{:error, %Ecto.Changeset{} = changeset} ->
				{:noreply, assign(socket, :changeset, changeset)}
		end
	end

	defp save_transaction(socket, :new, transaction_params) do
		case Store.create_transaction(transaction_params) do
			{:ok, _transaction} ->
				{:noreply,
				 socket
				 |> put_flash(:info, "Transaction created successfully")
				 |> push_redirect(to: socket.assigns.return_to)}

			{:error, %Ecto.Changeset{} = changeset} ->
				{:noreply, assign(socket, changeset: changeset)}
		end
	end
end
