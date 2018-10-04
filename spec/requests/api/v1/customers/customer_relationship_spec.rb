require 'rails_helper'

describe 'Customers relationships endpoint' do
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of associated invoices' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      create_list(:invoice, 7, merchant_id: merchant_id, customer_id: customer_id)

      get "/api/v1/customers/#{customer_id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(7)
      expect(invoices.first).to have_key("customer_id")
      expect(invoices.first).to have_key("merchant_id")
      expect(invoices.first).to have_key("status")
    end
  end

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a collection of associated transactions' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      create_list(:transaction, 3, invoice_id: invoice)

      get "/api/v1/customers/#{customer_id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(3)
      expect(transactions.first).to have_key("invoice_id")
      expect(transactions.first).to have_key("credit_card_number")
      expect(transactions.first).to have_key("result")
    end
  end
end
