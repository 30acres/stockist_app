class StockistsController < ApplicationController
  def index
    @all_countries = Country.all
    @stockists = Stockist.all #.page params[:page]
    @paged_stockists = Stockist.all.page params[:page]
    @hash = Gmaps4rails.build_markers(@stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end

  def show
    @stockist = Stockist.friendly.find(params[:id])
    @hash = Gmaps4rails.build_markers([@stockist]) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end
end
