class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    if params[:unit_price]
      render json: InvoiceItem.where('unit_price=?', (params[:unit_price].to_d*100).to_i)
    else
      render json: InvoiceItem.where(invoice_items_params)
    end
  end

  def show
    if params[:unit_price]
      render json: InvoiceItem.find_by('unit_price=?', (params[:unit_price].to_d*100).to_i)
    else
      render json: InvoiceItem.find_by(invoice_items_params)
    end
  end

  private

  def invoice_items_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at)
  end
end
