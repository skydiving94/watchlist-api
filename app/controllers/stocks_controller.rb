class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]

  def index
    @stocks = Stock.all
    json_response(@stocks)
  end

  def create
    @stock = Stock.create!(stock_params)
    json_response(@stock, :created)
  end

  def show
    json_response(@stock)
  end

  def update
    @stock.update(stock_params)
    head :no_content
  end

  def destroy
    @stock.destroy
    head :no_content
  end

private
  def stock_params
    params.permit(:code, :name, :highest, :lowest, :current, :difference)
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
