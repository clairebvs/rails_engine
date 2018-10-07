class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant_revenue = Merchant.total_revenue_for_a_merchant(params[:id]).round(2) /100
    render json: {"revenue" => "#{merchant_revenue}"}
  end
end
