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

      expect(invoice.count).to eq(1)
      expect(invoice.first).to have_key("customer_id")
      expect(invoice.first).to have_key("merchant_id")
      expect(invoice.first).to have_key("status")
    end
  end
end
