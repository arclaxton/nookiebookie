defmodule NookieBookie.Repo.Migrations.AccountBalance do
	use Ecto.Migration

	def change do
		alter table(:accounts) do
			add :balance, :float
		end
	end
end
