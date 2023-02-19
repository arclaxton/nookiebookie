defmodule Babook.Repo do
  use Ecto.Repo,
    otp_app: :babook,
    adapter: Ecto.Adapters.SQLite3
end
