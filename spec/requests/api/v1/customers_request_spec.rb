require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 4)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.count).to eq 4
  end
end
