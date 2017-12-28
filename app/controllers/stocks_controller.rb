class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]

  def index
    @stocks = current_administrator.stocks
    json_response(@stocks)
  end

  def create
    @stock = current_administrator.stocks.create!(stock_create_params)
    json_response(@stock, :created)
  end

  def show
    json_response(@stock)
  end

  def update
    prevVal = @stock.current
    @stock.update(stock_update_params)

    if @stock.current > @stock.highest
      @stock.highest = @stock.current
    end

    if @stock.current < @stock.lowest
      @stock.lowest = @stock.current
    end

    @stock.difference = @stock.current - prevVal
  end

  def destroy
    @stock.destroy
    head :no_content
  end

private
  def stock_create_params
    params.permit(:code, :name, :highest, :lowest, :current, :difference, :added_by)
  end

  def stock_update_params
    params.permit(:code, :name, :current)
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
