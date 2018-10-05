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

  it 'can find one invoice by params customer id' do
    merchant_id = create(:merchant).id
    customer_id_1 = create(:customer, id: 1).id
    customer_id_2 = create(:customer, id: 2).id
    invoice_1 = create(:invoice, merchant_id: merchant_id, customer_id: customer_id_1)
    invoice_2 = create(:invoice, merchant_id: merchant_id, customer_id: customer_id_2)

    get '/api/v1/invoices/find?customer_id=2'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["customer_id"]).to eq(invoice_2.customer_id)
  end

  it 'can find one invoice by params merchant id' do
    merchant_id_1 = create(:merchant, id: 1).id
    merchant_id_2 = create(:merchant, id: 2).id
    customer_id_1 = create(:customer, id: 1).id
    customer_id_2 = create(:customer, id: 2).id
    invoice_1 = create(:invoice, merchant_id: merchant_id_1, customer_id: customer_id_1)
    invoice_2 = create(:invoice, merchant_id: merchant_id_2, customer_id: customer_id_2)

    get '/api/v1/invoices/find?merchant_id=1'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["merchant_id"]).to eq(invoice_1.merchant_id)
  end

  it 'can find one invoice by params status' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_1 = create(:invoice, id: 1, merchant_id: merchant_id, customer_id: customer_id, status: 'shipped')
    invoice_2 = create(:invoice, id: 2, merchant_id: merchant_id, customer_id: customer_id, status: 'not_shipped')

    get '/api/v1/invoices/find?status=shipped'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["status"]).to eq(invoice_1.status)
  end

  it 'can find one invoice by params created_at' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_1 = create(:invoice, created_at: '11-02-2018', merchant_id: merchant_id, customer_id: customer_id)
    invoice_2 = create(:invoice, id: 2, created_at: '02-05-2018', merchant_id: merchant_id, customer_id: customer_id)

    get '/api/v1/invoices/find?created_at=02-05-2018'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_2.id)
  end

  it 'can find one invoice by params updated_at' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_1 = create(:invoice, id: 1, updated_at: '11-02-2018', merchant_id: merchant_id, customer_id: customer_id)
    invoice_2 = create(:invoice, id: 2, updated_at: '02-05-2018', merchant_id: merchant_id, customer_id: customer_id)

    get '/api/v1/invoices/find?updated_at=11-02-2018'

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(invoice_1.id)
  end
end
