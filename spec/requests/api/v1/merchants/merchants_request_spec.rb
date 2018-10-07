require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(5)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  # FINDER find?params

  it 'can find a merchant by parameter id' do
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)

    get "/api/v1/merchants/find?id=2"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'can find a merchant by parameter name' do
    merchant_1 = create(:merchant, id: 1, name: 'Jose')
    merchant_2 = create(:merchant, id: 2, name: 'Esteban')

    get "/api/v1/merchants/find?name=Esteban"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["name"]).to eq(merchant_2.name)
  end

  it 'can find a merchant by parameter created_at' do
    merchant_1 = create(:merchant, id: 1, created_at: '20-03-2018')
    merchant_2 = create(:merchant, id: 2, created_at: '23-04-2018')

    get "/api/v1/merchants/find?created_at=23-04-2018"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_2.id)
  end

  it 'can find a merchant by parameter updated_at' do
    merchant_1 = create(:merchant, id: 1, updated_at: '18-03-2018')
    merchant_2 = create(:merchant, id: 2, updated_at: '03-09-2018')

    get "/api/v1/merchants/find?updated_at=18-03-2018"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_1.id)
  end

  # FINDER find_all?

  it 'can find all merchants by params id' do
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    merchant_3 = create(:merchant, id: 3)

    get "/api/v1/merchants/find_all?id=3"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.first["id"]).to eq(merchant_3.id)
  end

  it 'can find all merchants by params name' do
    merchant_1 = create(:merchant, id: 1, name: 'Sylvana')
    merchant_2 = create(:merchant, id: 2, name: 'Sylvana')
    merchant_3 = create(:merchant, id: 3, name: 'Camilla')

    get "/api/v1/merchants/find_all?name=Sylvana"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["id"]).to eq(merchant_1.id)
  end

  it 'can find all merchants by parameter created_at' do
    merchant_1 = create(:merchant, id: 1, created_at: '20-03-2018')
    merchant_2 = create(:merchant, id: 2, created_at: '23-04-2018')
    merchant_3 = create(:merchant, id: 3, created_at: '23-04-2018')

    get "/api/v1/merchants/find_all?created_at=23-04-2018"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["id"]).to eq(merchant_2.id)
  end

  it 'can find all merchants by parameter updated_at' do
    merchant_1 = create(:merchant, id: 1, updated_at: '18-03-2018')
    merchant_2 = create(:merchant, id: 2, updated_at: '03-09-2018')
    merchant_3 = create(:merchant, id: 3, updated_at: '03-09-2018')

    get "/api/v1/merchants/find_all?updated_at=03-09-2018"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
    expect(merchant.first["id"]).to eq(merchant_2.id)
  end

  it 'finds a random merchant' do
    merchant = create(:merchant)

    get '/api/v1/merchants/random.json'

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.count).to eq(2)
  end

  # Business Intelligence Enpoint
  it 'returns the total revenue for all merchants on a date' do
    allow(Merchant).to receive(:total_revenue_all_merchants_on_date).and_return(12)

    get '/api/v1/merchants/revenue?date=2018-08-12'

    merchant_revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_revenue["total_revenue"]).to eq("0.12")
  end

  it 'returns the top merchants based on total revenue' do
    allow(Merchant).to receive(:top_merchants_by_total_revenue).and_return('Joe')

    get '/api/v1/merchants/most_revenue?quantity=1'

    expect(response).to be_successful
    expect(response.body).to eq("Joe")
  end

  it 'returns the top merchants based on items sold' do
    allow(Merchant).to receive(:top_merchants_by_items_sold).and_return('Joe')

    get '/api/v1/merchants/most_items?quantity=1'

    expect(response).to be_successful
    expect(response.body).to eq("Joe")
  end

  it 'returns the total revenue based on successful transactions for a merchant' do
    allow(Merchant).to receive(:total_revenue_for_a_merchant).and_return(16)

    merchant_id = create(:merchant, name: 'Joe', id: 2).id

    get "/api/v1/merchants/#{merchant_id}/revenue"

    merchant_revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_revenue["revenue"]).to eq("0.16")
  end

  it 'returns the total revenue based on successful transactions for a merchant on a specific date for invoice' do
    allow(Merchant).to receive(:total_revenue_for_a_merchant_on_date).and_return(10)

    merchant_id = create(:merchant, name: 'Joe', id: 2).id

    get "/api/v1/merchants/#{merchant_id}/revenue?date=2018-03-04"

    merchant_revenue = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant_revenue["revenue"]).to eq("0.1")
  end
end
