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

  context 'GET /api/v1/invoices/:id/items' do
    it 'returns a collection of associated items' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      item_1 = create(:item, merchant_id: merchant_id).id
      invoice_item = create(:invoice_item, item_id: item_1, invoice_id: invoice_id)

      get "/api/v1/invoices/#{invoice_id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(1)
      expect(items.first).to have_key("name")
      expect(items.first).to have_key("description")
      expect(items.first).to have_key("unit_price")
      expect(items.first).to have_key("merchant_id")
    end
  end

  context 'GET /api/v1/invoices/:id/customer' do
    it 'returns the associated customer' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      item_id = create(:item, merchant_id: merchant_id).id
      create_list(:invoice_item, 3, invoice_id: invoice_id, item_id: item_id)

      get "/api/v1/invoices/#{invoice_id}/customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer.count).to eq(3)
      expect(customer).to have_key("first_name")
      expect(customer).to have_key("last_name")
    end
  end

  context 'GET /api/v1/invoices/:id/merchant' do
    it 'returns the associated merchant' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
      item_id = create(:item, merchant_id: merchant_id).id
      create_list(:invoice_item, 3, invoice_id: invoice_id, item_id: item_id)

      get "/api/v1/invoices/#{invoice_id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant.count).to eq(2)
      expect(merchant).to have_key("name")
      expect(merchant).to have_key("id")
    end
  end
end
