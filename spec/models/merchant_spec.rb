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
      invoice_items_1 = create(:invoice_items, item_id: item_id, quantity: 2, unit_price: 4)

      expect(Merchant.total_revenue_all_merchants_on_date).to eq(8)
    end
  end

end
