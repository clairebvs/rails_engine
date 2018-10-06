require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    merchant_id = create(:merchant).id
    create_list(:item, 9, merchant_id: merchant_id)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq 9
  end
end
