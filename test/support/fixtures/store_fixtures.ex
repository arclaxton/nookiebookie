defmodule NookieBookie.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NookieBookie.Store` context.
  """

  @doc """
  Generate a unique account plaid_id.
  """
  def unique_account_plaid_id, do: "some plaid_id#{System.unique_integer([:positive])}"

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        name: "some name",
        owner: "some owner",
        plaid_id: unique_account_plaid_id()
      })
      |> NookieBookie.Store.create_account()

    account
  end

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        account: 42,
        amount: 120.5,
        budget_allocation: 42,
        category: "some category",
        merchant: "some merchant",
        transfer: true
      })
      |> NookieBookie.Store.create_transaction()

    transaction
  end
end
