require 'rails_helper'

describe 'Merchants relationships endpoint' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
      id = create(:merchant).id
      create_list(:item, 5, merchant_id: id)

      get "/api/v1/merchants/#{id}/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items.count).to eq(5)
    end
  end
end
