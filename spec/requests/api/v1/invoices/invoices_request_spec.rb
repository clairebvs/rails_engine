require 'rails_helper'

describe 'Invoices API' do
  it 'sends a list of invoices' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    create_list(:invoice, 9, merchant_id: merchant_id, customer_id: customer_id)

    get '/api/v1/invoices'

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq 9
  end

  it 'can get one invoice by its id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end

  # FINDER find

  it 'can find one invoice by params id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice = create(:invoice, id: 1, merchant_id: merchant_id, customer_id: customer_id)
    invoice_2 = create(:invoice, id: 2, merchant_id: merchant_id, customer_id: customer_id)

    get '/api/v1/invoices/find?id=2'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_2.id)
  end
end
