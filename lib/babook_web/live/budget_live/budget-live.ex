defmodule BabookWeb.BudgetLive.Budget do
	use BabookWeb, :live_view
	alias Babook.Store

	def mount(_params, _sesion, socket) do
		today = Date.utc_today()
		month = "#{today.year}-#{"#{today.month}" |> String.pad_leading(2, "0")}"
		categories = Store.list_categories()
		budgets = Store.get_budgets_for_month()

		{:ok, assign(socket, 
			year: today.year,
			month: month,
			categories: categories,
			budgets: budgets,
			adding: false
			)}

	end

	def handle_params(_params, _url, socket) do
		case socket.assigns.live_action do
			:add_category -> 
				{:noreply, assign(socket, adding: true)}
			_ -> {:noreply, socket}
		end
	end

	def handle_event("choose_month", %{"month" => month}, socket) do
		{:noreply, assign(socket, month: month)}
	end
	def handle_event("add_category", _, socket) do
		{:noreply, assign(socket, adding: true)}
	end
	def handle_event("save_new_category", category_params, socket) do
		{_, category} = save_category(socket, :new, category_params)
		year = socket.assign.year
		for month <- socket.assign.month .. 12 do
			Store.create_budget(year, month, category, 0)
		end
	end

	def save_category(socket, :new, category_params) do
		case Store.create_category(category_params) do
			{:ok, category} ->
				{:noreply,
				 socket
				 |> put_flash(:info, "category #{category.name} created")
				 |> push_redirect(to: "/budget")}

			{:error, %Ecto.Changeset{} = changeset} ->
				{:noreply, assign(socket, changeset: changeset)}
		end
	end
end