defmodule NookieBookie.Repo do
  use Ecto.Repo,
    otp_app: :nookiebookie,
    adapter: Ecto.Adapters.SQLite3
end
