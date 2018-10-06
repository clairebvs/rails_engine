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

    get '/api/v1/items/find?unit_price=12'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["unit_price"]).to eq(item_1.unit_price)
  end

  it 'can find one item by params merchant id' do
    merchant_id_1 = create(:merchant, id: 2).id
    merchant_id_2 = create(:merchant, id: 3).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id_2)
    item_2 = create(:item, id: 2, merchant_id: merchant_id_1)

    get '/api/v1/items/find?merchant_id=3'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["merchant_id"]).to eq(item_1.merchant_id)
  end

  it 'can find one item by params created at' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, merchant_id: merchant_id, created_at: '2018-10-15')
    item_2 = create(:item, merchant_id: merchant_id, created_at: '2018-09-15')

    get '/api/v1/items/find?created_at=2018-09-15'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(item_2.id)
  end

  it 'can find one item by params updated at' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, merchant_id: merchant_id, updated_at: '2018-10-15')
    item_2 = create(:item, merchant_id: merchant_id, updated_at: '2017-09-15')

    get '/api/v1/items/find?updated_at=2017-09-15'

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(item_2.id)
  end

  # FINDER find_all?query=params

  it 'can find all items by params id' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id)
    item_2 = create(:item, id: 2, merchant_id: merchant_id)

    get '/api/v1/items/find_all?id=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.first["id"]).to eq(item_2.id)
  end

  it 'can find all items by params name' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, name: 'bottle')
    item_2 = create(:item, id: 2, merchant_id: merchant_id, name: 'key')
    item_3 = create(:item, id: 3, merchant_id: merchant_id, name: 'key')
    item_4 = create(:item, id: 4, merchant_id: merchant_id, name: 'key')

    get '/api/v1/items/find_all?name=key'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items.first["name"]).to eq(item_2.name)
  end

  it 'can find all items by params description' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, description: 'great')
    item_2 = create(:item, id: 2, merchant_id: merchant_id, description: 'useful')
    item_3 = create(:item, id: 3, merchant_id: merchant_id, description: 'useful')

    get '/api/v1/items/find_all?description=useful'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["description"]).to eq(item_2.description)
  end

  it 'can find all items by params price' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id, unit_price: 12)
    item_2 = create(:item, id: 2, merchant_id: merchant_id, unit_price: 1)
    item_3 = create(:item, id: 3, merchant_id: merchant_id, unit_price: 1)

    get '/api/v1/items/find_all?unit_price=1'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["unit_price"]).to eq(item_2.unit_price)
  end

  it 'can find all items by params merchant id' do
    merchant_id_1 = create(:merchant, id: 2).id
    merchant_id_2 = create(:merchant, id: 3).id
    item_1 = create(:item, id: 1, merchant_id: merchant_id_2)
    item_2 = create(:item, id: 2, merchant_id: merchant_id_1)
    item_3 = create(:item, id: 3, merchant_id: merchant_id_1)

    get '/api/v1/items/find_all?merchant_id=2'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["merchant_id"]).to eq(item_2.merchant_id)
  end

  it 'can find all items by params created at' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, merchant_id: merchant_id, created_at: '2018-10-15')
    item_2 = create(:item, merchant_id: merchant_id, created_at: '2018-09-15')
    item_3 = create(:item, merchant_id: merchant_id, created_at: '2018-09-15')

    get '/api/v1/items/find_all?created_at=2018-09-15'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item_2.id)
  end

  it 'can find all items by params updated at' do
    merchant_id = create(:merchant).id
    item_1 = create(:item, merchant_id: merchant_id, updated_at: '2018-10-15')
    item_2 = create(:item, merchant_id: merchant_id, updated_at: '2017-09-15')
    item_3 = create(:item, merchant_id: merchant_id, updated_at: '2017-09-15')

    get '/api/v1/items/find_all?updated_at=2017-09-15'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item_2.id)
  end

end
