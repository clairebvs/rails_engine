class Api::V1::Items::SearchController < ApplicationController

  def index
    if params[:name]
      render json: Item.where('LOWER(name) = ?', params[:name].downcase)
    elsif params[:unit_price]
      render json: Item.where('unit_price=?', (params[:unit_price].to_d*100).to_i) if params[:unit_price]
    else
      render json: Item.where(item_search_params)
    end
  end

  def show
    if params[:name]
      render json: Item.find_by('LOWER(name) = ?', params[:name].downcase)
    else
      render json: Item.order(:id).find_by(item_search_params)
    end
  end

  private

  def item_search_params
      params[:unit_price] = params[:unit_price].delete('.').to_i if params[:unit_price]
      params.permit(:id, :description, :merchant_id, :created_at, :updated_at)
  end
end
