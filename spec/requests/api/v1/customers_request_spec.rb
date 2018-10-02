require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 4)

    get '/api/v1/customers'

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.count).to eq 4
  end

  it 'can get one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  # FINDER find

  it 'can find one customer by params id' do
    customer = create(:customer, id: 1)
    customer_2 = create(:customer, id: 2)

    get '/api/v1/customers/find?id=2'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(customer_2.id)
  end
end
