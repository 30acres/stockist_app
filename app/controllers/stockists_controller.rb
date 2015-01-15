class StockistsController < ApplicationController
  def index
    @stockists = Stockist.all
  end
end
