defmodule NookieBookieWeb.Router do
	use NookieBookieWeb, :router

	pipeline :browser do
		plug :accepts, ["html"]
		plug :fetch_session
		plug :fetch_live_flash
		plug :put_root_layout, {NookieBookieWeb.LayoutView, :root}
		plug :protect_from_forgery
		plug :put_secure_browser_headers
	end

	pipeline :api do
		plug :accepts, ["json"]
	end

	scope "/", NookieBookieWeb do
		pipe_through :browser

		get "/", PageController, :index

		live "/budget", BudgetLive.Budget, :index
		live "/budget/category/new", BudgetLive.Budget, :add_category
		live "/budget/:id/edit", BudgetLive.Budget, :edit

		live "/transactions", TransactionLive.Transactions, :index
		live "/transactions/new", TransactionLive.Transactions, :new
		live "/transactions/:id/edit", TransactionLive.Transactions, :edit

		live "/accounts", AccountLive.Index, :index
		live "/accounts/new", AccountLive.Index, :new
		live "/accounts/:id/edit", AccountLive.Index, :edit
		live "/accounts/:id/", AccountLive.Index, :show

		live "/transactions/:id", TransactionLive.Show, :show
		live "/transactions/:id/show/edit", TransactionLive.Show, :edit

	end

	# Other scopes may use custom stacks.
	scope "/api", NookieBookieWeb do
		pipe_through :api
		# Plaid-link
		get "/create_link_token", PlaidController, :create_link_token
		post "/exchange_public_token", PlaidController, :exchange_public_token
		get "/data", PlaidController, :get_data
		get "/is_account_connected", PlaidController, :is_account_connected
	end

	# Enables LiveDashboard only for development
	#
	# If you want to use the LiveDashboard in production, you should put
	# it behind authentication and allow only admins to access it.
	# If your application does not have an admins-only section yet,
	# you can use Plug.BasicAuth to set up some basic authentication
	# as long as you are also using SSL (which you should anyway).
	if Mix.env() in [:dev, :test] do
		import Phoenix.LiveDashboard.Router

		scope "/" do
			pipe_through :browser

			live_dashboard "/dashboard", metrics: NookieBookieWeb.Telemetry
		end
	end

	# Enables the Swoosh mailbox preview in development.
	#
	# Note that preview only shows emails that were sent by the same
	# node running the Phoenix server.
	if Mix.env() == :dev do
		scope "/dev" do
			pipe_through :browser

			forward "/mailbox", Plug.Swoosh.MailboxPreview
		end
	end
end
