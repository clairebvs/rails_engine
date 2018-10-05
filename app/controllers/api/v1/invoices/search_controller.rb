class Api::V1::Invoices::SearchController < ApplicationController

  def show
    render json: Invoice.find_by(invoices_params)
  end

  private

  def invoices_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at)
  end
end
