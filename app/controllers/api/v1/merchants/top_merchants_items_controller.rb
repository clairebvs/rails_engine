class Api::V1::Merchants::TopMerchantsItemsController < ApplicationController
  def index
    render json: Merchant.top_merchants_by_items_sold(params[:quantity])
  end
end
