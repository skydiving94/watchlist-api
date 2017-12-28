class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  def index
    @stocks = Stock.all
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
    stock =
    @stock.update(stock_update_params)

    if @stock.current > @stock.highest
      @stock.highest = @stock.current
    end

    if @stock.current < @stock.lowest
      @stock.lowest = @stock.current
    end

    @stock.difference = @stock.current - prevVal
    puts "difference is #{@stock.difference}"

    # FIXME: Is there some more elegant way to format this so that I do not call
    #         update twice?
    @stock.update({
      code: @stock.code,
      name: @stock.name,
      highest: @stock.highest,
      lowest: @stock.lowest,
      current: @stock.current,
      difference: @stock.difference
      })
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
    params.permit(:current)
  end

  def set_stock
    @stock = Stock.find(params[:id])
  end
end
