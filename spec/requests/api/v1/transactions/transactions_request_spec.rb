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

  it 'can get one transaction by its id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    id = create(:transaction, id: 2, invoice_id: invoice_id).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id)
  end

  # FINDER find?query=parameter

  it 'can find one transaction by params id' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    transaction = create(:transaction, id: 1, invoice_id: invoice_id)
    transaction_2 = create(:transaction, id: 2, invoice_id: invoice_id)

    get '/api/v1/transactions/find?id=2'

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(transaction_2.id)
  end

  it 'can find one transaction by params credit card number' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    transaction = create(:transaction, id: 1, invoice_id: invoice_id, credit_card_number: '13311')
    transaction_2 = create(:transaction, id: 2, invoice_id: invoice_id, credit_card_number: '13322')

    get '/api/v1/transactions/find?credit_card_number=13322'

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["credit_card_number"]).to eq(transaction_2.credit_card_number)
  end

  it 'can find one transaction by params result' do
    merchant_id = create(:merchant).id
    customer_id = create(:customer).id
    invoice_id = create(:invoice, merchant_id: merchant_id, customer_id: customer_id).id
    transaction_1 = create(:transaction, id: 1, invoice_id: invoice_id, result: 'success')
    transaction_2 = create(:transaction, id: 2, invoice_id: invoice_id, result: 'failed')

    get '/api/v1/transactions/find?result=success'

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["result"]).to eq(transaction_1.result)
  end
end
