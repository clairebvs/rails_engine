class Api::V1::Merchants::TopMerchantsRevenueController < ApplicationController

  def index
    render json: Merchant.top_merchants_by_total_revenue(params[:quantity])
  end
end
