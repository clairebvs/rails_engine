require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should belong_to(:merchant)}
  end

  describe '.top_items_by_revenue' do
    it 'returns the top x items ranked by total revenue generated' do
      merchant_1 = create(:merchant, name: 'Joe', id: 1)

      customer_1 = create(:customer, id: 1)

      invoice_id_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id).id
      invoice_id_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id).id

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, name: 'key', merchant_id: merchant_1.id)

      invoice_items_1 = create(:invoice_item, invoice_id: invoice_id_1, item_id: item_2.id, quantity: 2, unit_price: 4)
      invoice_items_2 = create(:invoice_item, invoice_id: invoice_id_2, item_id: item_2.id, quantity: 2, unit_price: 5)

      transaction = create(:transaction, invoice_id: invoice_id_1, result: 'success')
      transaction2 = create(:transaction, invoice_id: invoice_id_2, result: 'success')

      expect(Item.top_items_by_revenue(1)).to eq([item_2])
    end
  end
end
