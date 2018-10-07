class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    render json: Merchant.favorite_merchant_for_customer(params[:id])
  end
end
