defmodule NookieBookieWeb.BudgetLive.Budget do
	use NookieBookieWeb, :live_view
	alias NookieBookie.Store

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
		save_category(socket, :new, category_params) |> case do
			 {:noreply, socket} -> add_budgets(socket)
		end
	end

	def save_category(socket, :new, category_params) do
		case Store.create_category(category_params) do
			{:ok, category} ->
				{:noreply,
				 socket
				 |> put_flash(:info, "category #{category.name} created")
				 |> assign(new_category: category)
				 |> push_redirect(to: "/budget")}

			{:error, %Ecto.Changeset{} = changeset} ->
				{:noreply, assign(socket, changeset: changeset)}
		end
	end

	def add_budgets(socket) do
		IO.inspect socket
		year = socket.assigns.year
		month = socket.assigns.month 
			|> String.slice(String.length(socket.assigns.month)-2, 2)
			|> String.to_integer
		for month <- month .. 12 do
			Store.create_budget(year, month, socket.assigns.new_category.id, 0.0)
		end
		{:noreply, socket}
	end
end