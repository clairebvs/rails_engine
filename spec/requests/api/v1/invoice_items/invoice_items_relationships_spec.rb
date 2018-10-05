require 'rails_helper'

describe 'InvoiceItems relationships endpoint' do
  context 'GET /api/v1/invoice_items/:id/invoice' do
    it 'returns the associated invoice' do
      merch_id = create(:merchant).id
      item_id = create(:item, merchant_id: merch_id).id
      cust_id = create(:customer).id
      invoice_id = create(:invoice, customer_id: cust_id, merchant_id: merch_id).id
      invoice_it_id = create(:invoice_item, item_id: item_id, invoice_id: invoice_id).id


      get "/api/v1/invoice_items/#{invoice_it_id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(6)
    end
  end

  context 'GET /api/v1/invoice_items/:id/item' do
    it 'returns the associated item' do
      merch_id = create(:merchant).id
      item_id = create(:item, merchant_id: merch_id).id
      cust_id = create(:customer).id
      invoice_id = create(:invoice, customer_id: cust_id, merchant_id: merch_id).id
      invoice_it_id = create(:invoice_item, item_id: item_id, invoice_id: invoice_id).id


      get "/api/v1/invoice_items/#{invoice_it_id}/item"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.count).to eq(7)
    end
  end
end
