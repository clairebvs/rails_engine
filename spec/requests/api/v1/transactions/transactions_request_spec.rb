require 'rails_helper'

describe 'Transactions API' do
  it 'sends a list of transactions' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    create_list(:transaction, 3, invoice_id: invoice_id)

    get '/api/v1/transactions'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq 3
  end
end
