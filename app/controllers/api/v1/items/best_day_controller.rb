class Api::V1::Items::BestDayController < ApplicationController

  def show
    render json: Item.best_day_for_item(params[:id])
  end
end
