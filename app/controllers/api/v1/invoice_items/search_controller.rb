class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.find_by(invoice_items_params)
  end

  private

  def invoice_items_params
    params.permit(:id, :item_id)
  end
end