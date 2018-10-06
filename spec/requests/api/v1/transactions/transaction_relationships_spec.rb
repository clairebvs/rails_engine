require 'rails_helper'

describe 'Transactions relationships endpoint' do
  context 'GET /api/v1/transactions/:id/invoice' do
    it 'returns the associated invoice' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice_id = create(:invoice, customer_id: customer.id, merchant_id: merchant.id).id
      transaction = create(:transaction, invoice_id: invoice_id)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(4)
    end
  end
end
