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
end
