class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params[:date]
      date = Date.parse("#{params[:date]} 00:00:00 UTC")
      merchant_date_revenue = Merchant.total_revenue_for_a_merchant_on_date(date, params[:id]).round(2)/100
      render json: {"revenue" => "#{merchant_date_revenue}"}
    else
      merchant_revenue = Merchant.total_revenue_for_a_merchant(params[:id]).round(2) /100
      render json: {"revenue" => "#{merchant_revenue}"}
    end
  end
end
