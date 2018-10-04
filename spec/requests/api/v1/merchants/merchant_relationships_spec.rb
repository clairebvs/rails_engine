require 'rails_helper'

describe 'Merchants relationships endpoint' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
      id = create(:merchant).id
      create_list(:item, 5, merchant_id: id)

      get "/api/v1/merchants/#{id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(items.count).to eq(5)
    end
  end

  context 'GET /api/v1/merchants/:id/invoices' do
    it 'returns a collection of invoices associated with that merchant from their known orders' do
      id = create(:merchant).id
      customer_id = create(:customer).id
      create_list(:invoice, 4, merchant_id: id, customer_id: customer_id)

      get "/api/v1/merchants/#{id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(5)
    end
  end
end
