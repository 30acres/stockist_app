class StockistsController < ApplicationController
  def index
    @stockists = Stockist.all
    @hash = Gmaps4rails.build_markers(@stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end

  def show
    @stockist = Stockist.find(params[:id])
    @hash = Gmaps4rails.build_markers([@stockist]) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end
end
