require 'rails_helper'

describe 'Invoices relationships endpoint' do
  context 'GET /api/v1/invoices/:id/transactions' do
    it 'returns a collection of associated transactions' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      create_list(:transaction, 8, invoice_id: invoice_id)

      get "/api/v1/invoices/#{invoice_id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(8)
      expect(transactions.first).to have_key("invoice_id")
      expect(transactions.first).to have_key("result")
      expect(transactions.first).to have_key("credit_card_number")
    end
  end

  context 'GET /api/v1/invoices/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      item_id = create(:item, merchant_id: merchant_id).id
      create_list(:invoice_item, 3, invoice_id: invoice_id, item_id: item_id)

      get "/api/v1/invoices/#{invoice_id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(3)
      expect(invoice_items.first).to have_key("invoice_id")
      expect(invoice_items.first).to have_key("item_id")
      expect(invoice_items.first).to have_key("quantity")
      expect(invoice_items.first).to have_key("unit_price")
    end
  end
end
