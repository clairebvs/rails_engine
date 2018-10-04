class Api::V1::Merchants::RevenueDateController < ApplicationController

  def show
      parsed_date = Date.parse("#{params[:date]} 00:00:00 UTC")
      total_revenue = Merchant.total_revenue_all_merchants_on_date(parsed_date)
      render json: {"total_revenue" => "#{total_revenue.round(2)/100}"}
  end

end
