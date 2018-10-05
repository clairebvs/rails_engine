require 'rails_helper'

describe 'Items relationships endpoint' do
  context 'GET /api/v1/items/:id/invoice_items' do
    it 'returns a collection of associated invoice items' do
      merch_id = create(:merchant).id
      item_id = create(:item, merchant_id: merch_id).id
      cust_id = create(:customer).id
      invoice_id = create(:invoice, customer_id: cust_id, merchant_id: merch_id).id
      create_list(:invoice_item, 6, item_id: item_id, invoice_id: invoice_id)

      get "/api/v1/items/#{item_id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items.count).to eq(6)
      expect(invoice_items.first).to have_key("item_id")
      expect(invoice_items.first).to have_key("invoice_id")
      expect(invoice_items.first).to have_key("quantity")
      expect(invoice_items.first).to have_key("unit_price")
    end
  end

  context 'GET /api/v1/items/:id/merchant' do
    it 'returns the associated merchant' do
      merch_id = create(:merchant).id
      item_id = create(:item, merchant_id: merch_id).id

      get "/api/v1/items/#{item_id}/merchant"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)

      expect(merchant.count).to eq(4)
      expect(merchant.first).to have_key("item_id")
      expect(merchant.first).to have_key("invoice_id")
      expect(merchant.first).to have_key("quantity")
      expect(merchant.first).to have_key("unit_price")
    end
  end
end
