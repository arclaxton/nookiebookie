defmodule BabookWeb.Router do
	use BabookWeb, :router

	pipeline :browser do
		plug :accepts, ["html"]
		plug :fetch_session
		plug :fetch_live_flash
		plug :put_root_layout, {BabookWeb.LayoutView, :root}
		plug :protect_from_forgery
		plug :put_secure_browser_headers
	end

	pipeline :api do
		plug :accepts, ["json"]
	end

	scope "/", BabookWeb do
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

		live "/transactions/:id", TransactionLive.Show, :show
		live "/transactions/:id/show/edit", TransactionLive.Show, :edit

		live "/accounts/:id", AccountLive.Show, :show
		live "/accounts/:id/show/edit", AccountLive.Show, :edit
		
	end

	# Other scopes may use custom stacks.
	# scope "/api", BabookWeb do
	#   pipe_through :api
	# end

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

			live_dashboard "/dashboard", metrics: BabookWeb.Telemetry
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
