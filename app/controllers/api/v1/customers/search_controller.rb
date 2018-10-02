class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: Customer.where('LOWER(first_name) = ?', params[:first_name].downcase) if params[:first_name]
    render json: Customer.where('LOWER(last_name) = ?', params[:last_name].downcase) if params[:last_name]
    if params[:id] || params[:created_at] || params[:updated_at]
      render json: Customer.where(customer_params)
    end
  end

  def show
    if params[:first_name]
      render json: Customer.find_by('LOWER(first_name) = ?', params[:first_name].downcase)
    elsif params[:last_name]
      render json: Customer.find_by('LOWER(last_name) = ?', params[:last_name].downcase)
    elsif params[:id] || params[:created_at] || params[:updated_at]
      render json: Customer.find_by(customer_params)
    end
  end

  private

  def customer_params
      params.permit(:id, :created_at, :updated_at)
  end
end
