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

  it 'can find one customer by params first_name' do
    customer_1 = create(:customer, first_name: 'Joseph')
    customer_2 = create(:customer, first_name: 'Jessica')

    get '/api/v1/customers/find?first_name=Jessica'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["first_name"]).to eq(customer_2.first_name)
  end

  it 'can find one customer by params last_name' do
    customer_1 = create(:customer, last_name: 'Ande')
    customer_2 = create(:customer, last_name: 'Biur')

    get '/api/v1/customers/find?last_name=Ande'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["last_name"]).to eq(customer_1.last_name)
  end

  it 'can find one customer by params created_at' do
    customer_1 = create(:customer, created_at: '11-02-2018')
    customer_2 = create(:customer, created_at: '02-05-2018')

    get '/api/v1/customers/find?created_at=02-05-2018'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(customer_2.id)
  end

  it 'can find one customer by params updated_at' do
    customer_1 = create(:customer, updated_at: '02-08-2018')
    customer_2 = create(:customer, updated_at: '02-22-2018')

    get '/api/v1/customers/find?updated_at=02-08-2018'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(customer_1.id)
  end

  #  FINDER find_all?..

  it 'can find all customers by params id' do
    customer = create(:customer, id: 1)
    customer_2 = create(:customer, id: 2)
    customer_3 = create(:customer, id: 3)

    get '/api/v1/customers/find_all?id=3'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.first["id"]).to eq(customer_3.id)
  end

  it 'can find all customers by params first_name' do
    customer_1 = create(:customer, first_name: 'Joe')
    customer_2 = create(:customer, first_name: 'Joe')
    customer_3 = create(:customer, first_name: 'Emily')

    get '/api/v1/customers/find_all?first_name=Joe'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(2)
    expect(customer.first["first_name"]).to eq(customer_1.first_name)
  end

  it 'can find all customers by params last name' do
    customer_1 = create(:customer, last_name: 'Favre')
    customer_2 = create(:customer, last_name: 'Perez')
    customer_3 = create(:customer, last_name: 'Perez')
    customer_4 = create(:customer, last_name: 'Perez')

    get '/api/v1/customers/find_all?last_name=Perez'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(3)
    expect(customer.last["last_name"]).to eq(customer_4.last_name)
  end

  it 'can find all customers by params created at' do
    customer_1 = create(:customer, created_at: '09-12-2018')
    customer_2 = create(:customer, created_at: '04-02-2018')
    customer_3 = create(:customer, created_at: '09-12-2018')

    get '/api/v1/customers/find_all?created_at=09-12-2018'

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer.count).to eq(2)
    expect(customer.last["id"]).to eq(customer_3.id)
  end

end
