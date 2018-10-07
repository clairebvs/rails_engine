require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
  end
  describe 'relationships' do
    it {should have_many(:items)}
    it {should have_many(:invoices)}
    xit {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
    xit {should have_many(:transactions).through(:invoices)}
  end

  describe '.total_revenue_all_merchants_on_date' do
    xit 'should return the total revenue for all merchants on a date' do
      merchant_id = create(:merchant).id
      customer_id = create(:customer).id
      invoice = create(:invoice, merchant_id: merchant_id, customer_id: customer_id)
      item_id = create(:item, merchant_id: merchant_id).id
      invoice_items_1 = create(:invoice_item, item_id: item_id, quantity: 2, unit_price: 4)

      expect(Merchant.total_revenue_all_merchants_on_date).to eq(8)
    end
  end
  describe '.top_merchants_by_total_revenue' do
    it 'should return the name of the top merchant' do
      merchant = create(:merchant, name: 'Joe', id: 2)
      merchant_id_2 = create(:merchant, name: 'Lisa').id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant.id, customer_id: customer_id).id
      item_id = create(:item, merchant_id: merchant.id).id
      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, quantity: 2, unit_price: 4)
      transaction = create(:transaction, invoice_id: invoice_id, result: 'success')

      expect(Merchant.top_merchants_by_total_revenue(1)).to eq([merchant])
    end
  end
  describe '.top_merchants_by_items_sold' do
    it 'should return the name of the top merchants' do
      merchant = create(:merchant, name: 'Joe', id: 2)
      merchant_id_2 = create(:merchant, name: 'Lisa').id
      customer_id = create(:customer).id
      invoice_id = create(:invoice, merchant_id: merchant.id, customer_id: customer_id).id
      item_id = create(:item, merchant_id: merchant.id).id
      item_id_2 = create(:item, merchant_id: merchant.id).id
      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id, item_id: item_id_2, quantity: 2, unit_price: 4)
      transaction = create(:transaction, invoice_id: invoice_id, result: 'success')

      expect(Merchant.top_merchants_by_items_sold(1)).to eq([merchant])
    end
  end

  describe '.favorite_customer_by_transaction' do
    it 'should return the name of the customer that has conducted the most total number of successful transactions' do
      merchant = create(:merchant, name: 'Joe', id: 2)

      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      invoice_id_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id).id
      invoice_id_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id).id

      item_id = create(:item, merchant_id: merchant.id).id
      item_id_2 = create(:item, merchant_id: merchant.id).id

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id_2, quantity: 2, unit_price: 4)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'success')

      expect(Customer.favorite_customer_by_transaction(merchant.id)).to eq(customer_1)
    end
  end

  describe '.total_revenue_for_a_merchant' do
    it 'should return the total revenue for one merchant accross successful transactions' do
      merchant = create(:merchant, name: 'Joe', id: 2)

      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      invoice_id_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id).id
      invoice_id_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id).id

      item_id = create(:item, merchant_id: merchant.id).id
      item_id_2 = create(:item, merchant_id: merchant.id).id

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id_2, quantity: 2, unit_price: 4)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'success')

      expect(Merchant.total_revenue_for_a_merchant(merchant.id)).to eq(16)
    end
  end

  describe '.total_revenue_for_a_merchant_for_date' do
    it 'should return the total revenue for one merchant accross successful transactions on a date' do
      date = '2018-03-04'
      parsed_date = Date.parse("#{date} 00:00:00 UTC")
      merchant = create(:merchant, name: 'Joe', id: 2)

      customer_1 = create(:customer, id: 1)
      customer_2 = create(:customer, id: 2)

      invoice_id_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id, updated_at: '2017-12-12').id
      invoice_id_2 = create(:invoice, merchant_id: merchant.id, customer_id: customer_1.id, updated_at: parsed_date).id

      item_id = create(:item, merchant_id: merchant.id).id
      item_id_2 = create(:item, merchant_id: merchant.id).id

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id_2, quantity: 2, unit_price: 5)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'success')

      expect(Merchant.total_revenue_for_a_merchant_on_date(parsed_date, merchant.id)).to eq(10)
    end
  end

  describe '.favorite_merchant_for_customer' do
    it 'returns a merchant where the customer has conducted the most successful transactions' do
      merchant_1 = create(:merchant, name: 'Joe', id: 1)
      merchant_2 = create(:merchant, name: 'Elena', id: 2)

      customer_1 = create(:customer, id: 1)

      invoice_id_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id).id
      invoice_id_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id).id

      item_id = create(:item, merchant_id: merchant_1.id).id
      item_id_2 = create(:item, merchant_id: merchant_1.id).id

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id_2, quantity: 2, unit_price: 5)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'success')

      expect(Merchant.favorite_merchant_for_customer(customer_1.id)).to eq(merchant_1)
    end
  end

end
