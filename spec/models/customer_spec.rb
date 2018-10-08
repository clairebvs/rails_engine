require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end
  describe 'relationships' do
    it {should have_many(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'Class Method .customers_with_pending_invoices' do
    it 'returns a collection of customers with pending invoices' do
      merchant_1 = create(:merchant, name: 'Joe', id: 1)
      merchant_2 = create(:merchant, name: 'Elena', id: 2)

      customer_1 = create(:customer, id: 1)

      invoice_id_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id, status: 'pending').id
      invoice_id_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id, status: 'pending').id

      item_id = create(:item, merchant_id: merchant_1.id).id
      item_id_2 = create(:item, merchant_id: merchant_1.id).id

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_id_2, quantity: 2, unit_price: 5)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'unsuccessful')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'unsuccessful')

      expect(Customer.customers_with_pending_invoices(merchant_1.id)).to eq([customer_1])
    end
  end
end
