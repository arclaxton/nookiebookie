defmodule Babook.StoreTest do
  use Babook.DataCase

  alias Babook.Store

  describe "accounts" do
    alias Babook.Store.Account

    import Babook.StoreFixtures

    @invalid_attrs %{name: nil, owner: nil, plaid_id: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Store.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Store.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{name: "some name", owner: "some owner", plaid_id: "some plaid_id"}

      assert {:ok, %Account{} = account} = Store.create_account(valid_attrs)
      assert account.name == "some name"
      assert account.owner == "some owner"
      assert account.plaid_id == "some plaid_id"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{name: "some updated name", owner: "some updated owner", plaid_id: "some updated plaid_id"}

      assert {:ok, %Account{} = account} = Store.update_account(account, update_attrs)
      assert account.name == "some updated name"
      assert account.owner == "some updated owner"
      assert account.plaid_id == "some updated plaid_id"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_account(account, @invalid_attrs)
      assert account == Store.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Store.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Store.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Store.change_account(account)
    end
  end

  describe "transactions" do
    alias Babook.Store.Transaction

    import Babook.StoreFixtures

    @invalid_attrs %{account: nil, amount: nil, budget_allocation: nil, category: nil, merchant: nil, transfer: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Store.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Store.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{account: 42, amount: 120.5, budget_allocation: 42, category: "some category", merchant: "some merchant", transfer: true}

      assert {:ok, %Transaction{} = transaction} = Store.create_transaction(valid_attrs)
      assert transaction.account == 42
      assert transaction.amount == 120.5
      assert transaction.budget_allocation == 42
      assert transaction.category == "some category"
      assert transaction.merchant == "some merchant"
      assert transaction.transfer == true
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{account: 43, amount: 456.7, budget_allocation: 43, category: "some updated category", merchant: "some updated merchant", transfer: false}

      assert {:ok, %Transaction{} = transaction} = Store.update_transaction(transaction, update_attrs)
      assert transaction.account == 43
      assert transaction.amount == 456.7
      assert transaction.budget_allocation == 43
      assert transaction.category == "some updated category"
      assert transaction.merchant == "some updated merchant"
      assert transaction.transfer == false
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_transaction(transaction, @invalid_attrs)
      assert transaction == Store.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Store.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Store.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Store.change_transaction(transaction)
    end
  end
end
