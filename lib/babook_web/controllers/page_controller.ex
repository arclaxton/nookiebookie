defmodule BabookWeb.PageController do
	use BabookWeb, :controller

	def index(conn, _params) do
		render(conn, "index.html")
	end
end
