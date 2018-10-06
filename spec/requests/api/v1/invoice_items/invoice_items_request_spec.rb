require 'rails_helper'

describe 'Invoice Items API' do
  it 'sends a list of invoice_items' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    create_list(:invoice_item, 5, item_id: item_id, invoice_id: invoice_id)

    get '/api/v1/invoice_items'

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq 5
  end

  it 'can get one invoice_items' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    id = create(:invoice_item, item_id: item_id, invoice_id: invoice_id).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(id)
  end

  # FINDER find

  it 'can find one invoice item by params id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, id: 3, item_id: item_id, invoice_id: invoice_id)
    invoice_item_2 = create(:invoice_item, id: 2, item_id: item_id, invoice_id: invoice_id)

    get "/api/v1/invoice_items/find?id=2"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_2.id)
  end

  it 'can find one invoice item by params item id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id_1 = create(:item, id: 2, merchant_id: merchant_id).id
    item_id_2 = create(:item, id: 3, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, id: 3, item_id: item_id_1, invoice_id: invoice_id)
    invoice_item_2 = create(:invoice_item, id: 2, item_id: item_id_2, invoice_id: invoice_id)

    get "/api/v1/invoice_items/find?item_id=2"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["item_id"]).to eq(invoice_item_1.item_id)
  end

  it 'can find one invoice item by params invoice id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id_1 = create(:invoice, id: 1, merchant_id: merchant_id, customer_id: customer_id).id
    invoice_id_2 = create(:invoice, id: 2, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id)

    get "/api/v1/invoice_items/find?invoice_id=2"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["invoice_id"]).to eq(invoice_item_2.invoice_id)
  end

  it 'can find one invoice item by params quantity' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, quantity: 5)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, quantity: 2)

    get "/api/v1/invoice_items/find?quantity=2"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["quantity"]).to eq(invoice_item_2.quantity)
  end

  it 'can find one invoice item by params unit price' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, unit_price: 190)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, unit_price: 80)

    get "/api/v1/invoice_items/find?unit_price=190"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["unit_price"]).to eq(invoice_item_1.unit_price)
  end

  it 'can find one invoice item by params created at' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, created_at: '2018-03-10')
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, created_at: '2018-01-24')

    get "/api/v1/invoice_items/find?created_at=2018-01-24"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_2.id)
  end

  it 'can find one invoice item by params updated at' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, updated_at: '2018-03-10')
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, updated_at: '2018-01-24')

    get "/api/v1/invoice_items/find?updated_at=2018-01-24"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["id"]).to eq(invoice_item_2.id)
  end

  # FINDER find_all?query=parameters

  it 'can find all invoices item by params id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, id: 3, item_id: item_id, invoice_id: invoice_id)
    invoice_item_2 = create(:invoice_item, id: 2, item_id: item_id, invoice_id: invoice_id)

    get "/api/v1/invoice_items/find_all?id=2"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.first["id"]).to eq(invoice_item_2.id)
  end

  it 'can find all invoice items by params invoice id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id_1 = create(:invoice, id: 1, merchant_id: merchant_id, customer_id: customer_id).id
    invoice_id_2 = create(:invoice, id: 2, merchant_id: merchant_id, customer_id: customer_id).id
    item_id = create(:item, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id)

    get "/api/v1/invoice_items/find_all?invoice_id=2"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first["invoice_id"]).to eq(invoice_item_2.invoice_id)
  end

  it 'can find all invoices item by params item id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    item_id_1 = create(:item, id: 2, merchant_id: merchant_id).id
    item_id_2 = create(:item, id: 3, merchant_id: merchant_id).id
    invoice_item_1 = create(:invoice_item, item_id: item_id_1, invoice_id: invoice_id)
    invoice_item_2 = create(:invoice_item, item_id: item_id_1, invoice_id: invoice_id)
    invoice_item_3 = create(:invoice_item, item_id: item_id_2, invoice_id: invoice_id)

    get "/api/v1/invoice_items/find_all?item_id=2"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first["item_id"]).to eq(invoice_item_1.item_id)
  end
end
