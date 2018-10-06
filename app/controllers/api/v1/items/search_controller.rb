class Api::V1::Items::SearchController < ApplicationController

  def show
    if params[:name]
      render json: Item.find_by('LOWER(name) = ?', params[:name].downcase)
    else
      render json: Item.find_by(item_search_params)
    end
  end

  private

  def item_search_params
    params.permit(:id, :description, :unit_price, :merchant_id, :created_at)
  end
end
