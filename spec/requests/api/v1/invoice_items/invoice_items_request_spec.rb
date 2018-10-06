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
end
