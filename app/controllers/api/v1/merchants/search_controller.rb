class Api::V1::Merchants::SearchController < ApplicationController

  def index
    if params[:name]
      render json: Merchant.where('LOWER(name) = ?', params[:name].downcase)
    else
      render json: Merchant.where(search_params)
    end
  end

  def show
    if params[:name]
      render json: Merchant.find_by('LOWER(name) = ?', params[:name].downcase)
    else
      render json: Merchant.find_by(search_params)
    end
  end

  private

  def search_params
    params.permit(:id, :created_at, :updated_at)
  end
end
