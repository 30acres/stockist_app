class StockistsController < ApplicationController
  def index
    @stockists = Stockist.all
    @hash = Gmaps4rails.build_markers(@stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end
end
