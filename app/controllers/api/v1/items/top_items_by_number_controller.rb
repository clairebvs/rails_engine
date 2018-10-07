class Api::V1::Items::TopItemsByNumberController < ApplicationController
  def index
    render json: Item.top_items_by_number_sold(params[:quantity])
  end
end
