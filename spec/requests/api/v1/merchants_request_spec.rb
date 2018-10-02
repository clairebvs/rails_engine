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

  xit 'can find a merchant by parameter created_at' do
    merchant_1 = create(:merchant, id: 1, created_at: '20-03-2018')
    merchant_2 = create(:merchant, id: 2, created_at: '23-04-2018')

    get "/api/v1/merchants/find?created_at=23-04-2018"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["created_at"]).to eq(merchant_2.created_at)
  end

  it 'can find all merchants by params id' do
    merchant_1 = create(:merchant, id: 1)
    merchant_2 = create(:merchant, id: 2)
    merchant_3 = create(:merchant, id: 3)

    get "/api/v1/merchants/find_all?id=3"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"].to eq(merchant_3.id))
  end

end