class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: Item.find_by(item_search_params)
  end

  private

  def item_search_params
    params.permit(:id)
  end
end
