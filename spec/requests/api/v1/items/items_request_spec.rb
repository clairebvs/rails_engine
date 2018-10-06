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

  it 'can get one item by its id' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  # FINDER find?query=parameter
  it 'can find one item by params id' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id)
    item_2 = create(:item, id: 2, merchant_id: merchant_id)

    get '/api/v1/items/find?id=2'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(item_2.id)
  end

  it 'can find one item by params name' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, name: 'bottle')
    item_2 = create(:item, id: 2, merchant_id: merchant_id, name: 'key')

    get '/api/v1/items/find?name=key'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["name"]).to eq(item_2.name)
  end

  it 'can find one item by params description' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, description: 'great')
    item_2 = create(:item, id: 2, merchant_id: merchant_id, description: 'useful')

    get '/api/v1/items/find?description=useful'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["description"]).to eq(item_2.description)
  end

  it 'can find one item by params price' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, unit_price: 12)
    item_2 = create(:item, id: 2, merchant_id: merchant_id, unit_price: 1)

    get '/api/v1/items/find?price=12'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["unit_price"]).to eq(item_1.unit_price)
  end

end
